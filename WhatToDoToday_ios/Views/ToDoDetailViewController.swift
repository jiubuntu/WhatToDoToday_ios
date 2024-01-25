import UIKit
import SwiftUI

class ToDoDetailViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    let dateStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 10
        return sv
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.cornerRadius = 7
        tf.textAlignment = .center
        return tf
    }()
    
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜선택"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.cornerRadius = 7
        tf.placeholder = "할일의 제목을 입력해주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .secondarySystemBackground
        tv.layer.cornerRadius = 7
        tv.text = "할일의 내용을 입력해주세요"
        tv.textColor = .lightGray
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.6862745098, blue: 0.937254902, alpha: 1)
        button.layer.cornerRadius = 7
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setNavigation()
        setUI()
        setupTextField()
        setupDatePicker()
        setupToolBar()
        makeConstraint()
    }
    
    private func config() {
        contentTextView.delegate = self
    }
    
    
    
    private func setNavigation() {
        // 네비게이션 바의 백버튼 폰트 색상 변경
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = UIColor.black // 색상을 원하는 색으로 변경
        }
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateTextField)
        view.addSubview(addButton)
        view.addSubview(dateStackView)
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupTextField() {
        dateTextField.frame = CGRect(x: 50,
                                     y: 300,
                                     width: view.frame.size.width-100,
                                     height: 50)
    }
    
    private func setupDatePicker() {
        // UIDatePicker 객체 생성
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정해 줌
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dateTextField.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        dateTextField.text = dateFormat(date: Date())
    }
    
    
    // MARK: - dateTextField 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        dateTextField.text = dateFormat(date: sender.date)
    }
    
    
    
    // MARK: - 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
    
    
    // MARK: - 툴바 세팅
    private func setupToolBar() {
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적당한 사이즈로 툴바 만들기
        toolBar.sizeToFit()
        dateTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        dateTextField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        dateTextField.resignFirstResponder()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            dateStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dateStackView.widthAnchor.constraint(equalToConstant: 200),
            dateStackView.heightAnchor.constraint(equalToConstant: 70),
            dateStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            dateTextField.widthAnchor.constraint(equalToConstant: 200),
            dateTextField.heightAnchor.constraint(equalToConstant: 35),
            
            dateLabel.topAnchor.constraint(equalTo: dateStackView.topAnchor, constant: 10),
            
            titleTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalToConstant: 300),
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            titleTextField.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 50),
            
            contentTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentTextView.widthAnchor.constraint(equalToConstant: 300),
            contentTextView.heightAnchor.constraint(equalToConstant: 300),
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            
            addButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 25)
            
        ])
    }
    
    // 다른 곳을 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension ToDoDetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "할일의 내용을 입력해주세요" {
            textView.text = nil
            textView.textColor = .black
            textView.textAlignment = .left
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "할일의 내용을 입력해주세요"
            textView.textColor = .lightGray
            textView.textAlignment = .center
        }
    }
}


// MARK: - preview를 위한...
#if DEBUG
struct ToDoDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ToDoDetailViewController()
            .toPreview()
    }
}
#endif
