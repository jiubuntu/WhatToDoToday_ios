import UIKit
import SwiftUI
import CoreData

class ToDoDetailViewController: UIViewController,GaugeChartDelegate {
    weak var delegate: ToDoDetailDelegate?
    
    let toDoEntityName: String = "Todo"
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let toDoViewModel = TodoViewModel(coreDataManager: CoreDataManager.shared)
    let gaugeChartData = GaugeChartData(coreDataManager: CoreDataManager.shared)
    
    var selectedToDo: Todo? {
        didSet {
            configureUIwithData()
        }
    }
    
    let datePicker = UIDatePicker()
    
    var previous = ""
    
    weak var gaugeDelegate: GaugeChartDelegate?
    
    
//    let deleteButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("삭제", for: .normal)
//        button.backgroundColor = UIColor.systemRed
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.layer.cornerRadius = 7
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        return button
//    }()
    
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
        tf.textColor = UIColor.black
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .secondarySystemBackground
        tv.layer.cornerRadius = 7
        tv.textColor = .black
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.3607843137, blue: 0.9215686275, alpha: 1)
        button.layer.cornerRadius = 7
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        setupTextField()
        setupDatePicker()
        setupToolBar()
        makeConstraint()
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
//        view.addSubview(deleteButton)
        
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
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
        // textField 날짜 표시 설정
        if let date = selectedToDo?.date {
            dateTextField.text = date
        } else {
            dateTextField.text = dateFormat(date: Date())
        }
        
    }
    
    
    // MARK: - dateTextField 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        dateTextField.text = dateFormat(date: sender.date)
    }
    
    
    
    // MARK: - 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
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
    
    
    // MARK: - 데이터를 뿌려주기
    private func configureUIwithData() {
        dateTextField.text = selectedToDo?.date
        titleTextField.text = selectedToDo?.memoTitle
        contentTextView.text = selectedToDo?.memoContent
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        dateTextField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        dateTextField.resignFirstResponder()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
//            deleteButton.widthAnchor.constraint(equalToConstant: 55),
//            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            
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
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.delegate?.didUpdateToDo()
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
    @objc func updateButtonTapped() {
        guard let targetToDo = selectedToDo else { return }
        guard let targetToDoDate = targetToDo.date else { return }
        guard let targetToDoTitle = targetToDo.memoTitle else { return }
        guard let targetToDoContent = targetToDo.memoContent else { return }
        
        
        targetToDo.date = dateTextField.text
        targetToDo.memoTitle = titleTextField.text
        targetToDo.memoContent = contentTextView.text
        
        toDoViewModel.updateToDo(
            newToDoData: targetToDo,
            completion: { result in
                switch result {
                case "success":
                    print("Todo 업데이트 완료")
                    self.showAlert(message: "저장되었습니다")
                    self.updateGaugeData()
                case "fail":
                    print("Todo 업데이트 실패")
                    self.showAlert(message: "저장에 실패하였습니다. 다시 시도해주세요")
                case "pkeyfindfail":
                    print("Todo Pkey 찾기 실패")
                    self.showAlert(message: "저장에 실패하였습니다. 다시 시도해주세요")
                default:
                    print("ToDo Update 알수없는 결과")
                    self.showAlert(message: "저장에 실패하였습니다. 다시 시도해주세요")
                }
            }
        )
    }
    
    // 다른 곳을 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func gaugeUpdateDataInCoreData() {
        if previous == "" {
            gaugeChartData.TodayUpdateProgress()
        }
    }
    
    func updateGaugeData() {
        gaugeDelegate?.updateGaugeData()
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
