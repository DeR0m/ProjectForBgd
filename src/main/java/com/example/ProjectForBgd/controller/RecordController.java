package com.example.ProjectForBgd.controller;

import com.example.ProjectForBgd.domain.Record;
import com.example.ProjectForBgd.domain.User;
import com.example.ProjectForBgd.repo.RecordRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class RecordController {

    @Autowired
    private RecordRepo recordRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        Iterable<Record> records = recordRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            records = recordRepo.findByTag(filter);
        } else {
            records = recordRepo.findAll();
        }

        model.addAttribute("records", records);
        model.addAttribute("filter", filter);

        return "records";
    }

    @PostMapping("/")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Record record,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        record.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("record", record);
        }else {

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();

                file.transferTo(new File(uploadPath + "/" + resultFilename));

                record.setFilename(resultFilename);
            }

            model.addAttribute("record", null);

            recordRepo.save(record);
        }
        Iterable<Record> records = recordRepo.findAll();

        model.addAttribute("records", records);

        return "records";
    }

    private void saveFile(@Valid Record record, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            record.setFilename(resultFilename);

        }
    }


    @GetMapping("{id}/editRecord")
    public String updateCategory(@PathVariable(value = "id") long id, Model model) {
        Record record = recordRepo.findById(id).orElseThrow();
        model.addAttribute("record", record);
        return "editRecord";
    }

    @PostMapping("/editRecord")
    public String saveCategory(
            @RequestParam("recordId") Record record,
            @RequestParam("text") String text,
            @RequestParam("number") float number,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        record.setText(text);
        record.setNumber(number);
        record.setTag(tag);
        saveFile(record, file);
        recordRepo.save(record);

        return "redirect:";
    }

    @PostMapping("{id}/remove")
    public String removeCategoryMain(@PathVariable(value = "id") long id) {
        Record record = recordRepo.findById(id).orElseThrow();
        recordRepo.delete(record);
        return "redirect:/";
    }
}
