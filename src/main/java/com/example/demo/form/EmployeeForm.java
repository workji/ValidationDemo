package com.example.demo.form;

import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * 従業員登録フォーム
 *
 * 実際のプロジェクトで使用する全ての入力要素を含む：
 * - テキスト入力
 * - ラジオボタン
 * - チェックボックス
 * - セレクトリスト
 * - 日付・時刻
 *
 * Lombokを使用せず、全てのGetter/Setterを手動実装
 */
public class EmployeeForm {

    // ========== テキスト項目 ==========

    @NotBlank
    @Size(min = 2, max = 50)
    private String employeeName;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Pattern(regexp = "^\\d{10,11}$")
    private String phoneNumber;

    @NotBlank
    @Pattern(regexp = "^\\d{7}$")
    private String postalCode;

    @NotBlank
    @Size(max = 200)
    private String address;

    // ========== ラジオボタン ==========

    @NotNull
    private String gender;  // "male", "female", "other"

    @NotNull
    private String employmentType;  // "fulltime", "parttime", "contract", "intern"

    // ========== チェックボックス ==========

    @NotNull
    private Boolean agreedToTerms;

    @Size(min = 1)
    private List<String> skills;

    // ========== セレクトリスト ==========

    @NotNull
    private Integer departmentId;

    @NotNull
    private String position;  // "manager", "leader", "member", "intern"

    // ========== 数値 ==========

    @NotNull
    @Min(value = 18)
    @Max(value = 70)
    private Integer age;

    @NotNull
    @Min(value = 3000000)
    @Max(value = 20000000)
    private Integer expectedSalary;

    // ========== 日付・時刻 ==========

    @NotNull
    private LocalDate desiredStartDate;

    @NotNull
    private LocalDate birthDate;

    @NotNull
    private LocalTime interviewTime;

    // ========== パスワード ==========

    @NotBlank
    @Size(min = 8, max = 20)
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).*$")
    private String password;

    private String passwordConfirm;

    // ========== その他 ==========

    @Size(max = 500)
    private String selfIntroduction;

    // ========== コンストラクタ ==========

    public EmployeeForm() {
    }

    // ========== Getter/Setter (Lombokを使わず手動実装) ==========

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
    }

    public Boolean getAgreedToTerms() {
        return agreedToTerms;
    }

    public void setAgreedToTerms(Boolean agreedToTerms) {
        this.agreedToTerms = agreedToTerms;
    }

    public List<String> getSkills() {
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getExpectedSalary() {
        return expectedSalary;
    }

    public void setExpectedSalary(Integer expectedSalary) {
        this.expectedSalary = expectedSalary;
    }

    public LocalDate getDesiredStartDate() {
        return desiredStartDate;
    }

    public void setDesiredStartDate(LocalDate desiredStartDate) {
        this.desiredStartDate = desiredStartDate;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public LocalTime getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(LocalTime interviewTime) {
        this.interviewTime = interviewTime;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getSelfIntroduction() {
        return selfIntroduction;
    }

    public void setSelfIntroduction(String selfIntroduction) {
        this.selfIntroduction = selfIntroduction;
    }
}