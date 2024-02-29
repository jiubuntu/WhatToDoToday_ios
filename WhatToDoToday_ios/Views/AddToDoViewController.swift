
import UIKit
import SwiftUI

class AddToDoViewController: UIViewController {
    
    let toDoViewModel = TodoViewModel(coreDataManager: CoreDataManager.shared)
    let gaugeChartData = GaugeChartData(coreDataManager: CoreDataManager.shared)
    
    let datePicker = UIDatePicker()
    
    var toDoDate: Date? {
        didSet {
//            setDate()
        }
    }
    
    var previous: String = ""
    
    
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
        tf.placeholder = "할 일의 제목을 입력해 주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .secondarySystemBackground
        tv.layer.cornerRadius = 7
        tv.text = "할 일의 내용을 입력해 주세요"
        tv.textColor = .lightGray
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가하기", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5649828315, green: 0.8381140828, blue: 0.7913190722, alpha: 1)
        button.layer.cornerRadius = 7
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
        dateTextField.text = Date().toString()
    }
    
    
    // MARK: - dateTextField 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        dateTextField.text = Date().toString()
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
        dateTextField.text = datePicker.date.toString()
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
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    // MARK: - Todo 추가
    @objc func addButtonTapped() {
        
        // MARK: - 아무것도 입력하지 않았을때 예외처리
        if dateTextField.text == nil {
            showAlert(message: "날짜를 입력해 주세요")
            return
        }
        
        if let textField = titleTextField.text, textField.isEmpty {
            showAlert(message: "할 일의 제목을 입력해 주세요")
            return
        }
        
        if let textView = contentTextView.text , textView == "할 일의 내용을 입력해 주세요" {
            showAlert(message: "할 일의 내용을 입력해 주세요")
            return
        }
        
        
        toDoViewModel.saveToDoData(
            complete: false,
            memoTitle: titleTextField.text,
            date: dateTextField.text,
            memoContent: contentTextView.text,
            completion: {
                print("저장완료")
                if self.previous == "" {
                    self.gaugeUpdateDataInCoreData()
                }
                self.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    private func gaugeUpdateDataInCoreData() {
        gaugeChartData.TodayUpdateProgress()
    }
}


extension AddToDoViewController: UITextViewDelegate {
    // 입력을 시작할때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray{
            textView.text = nil
            textView.textColor = .black
            textView.textAlignment = .left
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "할 일의 내용을 입력해 주세요"
            textView.textColor = .lightGray
            textView.textAlignment = .center
        }
    }
}



// MARK: - preview를 위한...
#if DEBUG
struct AddToDoViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AddToDoViewController()
            .toPreview()
    }
}
#endif
