package com.example.ProjectForBgd.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;

@Entity
@Table(name = "records")
public class Record {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private float number;
    private String text;
    @Length(max = 255, message = "Message too long (more than 255)")
    private String tag;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;
    private String filename;

    public Record() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public float getNumber() {
        return number;
    }

    public void setNumber(float number) {
        this.number = number;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getAuthorName(){
        return author != null ?author.getUsername() : "<none>";
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
}
