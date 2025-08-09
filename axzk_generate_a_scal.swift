import Foundation

// Define the API specification for the scalable chatbot parser

// 1. Define the ConversationModel to hold the conversation context
struct ConversationModel {
    var userMessage: String
    var chatbotResponse: String?
    var conversationHistory: [String]
}

// 2. Define the Intent enum to represent the possible user intents
enum Intent: String, Codable {
    case greet
    case askAboutWeather
    case bookFlight
    case cancelFlight
    case unknown
}

// 3. Define the EntityModel to hold the extracted entities from user input
struct EntityModel {
    var intent: Intent
    var entities: [String: String]
}

// 4. Define the ChatbotParser protocol to handle the chatbot logic
protocol ChatbotParser {
    func parseUserMessage(message: String) -> EntityModel
    func generateResponse(entity: EntityModel) -> String
}

// 5. Define the ScalableChatbotParser class to implement the ChatbotParser protocol
class ScalableChatbotParser: ChatbotParser {
    private let intentClassifier: IntentClassifier
    private let responseGenerator: ResponseGenerator
    
    init(intentClassifier: IntentClassifier, responseGenerator: ResponseGenerator) {
        self.intentClassifier = intentClassifier
        self.responseGenerator = responseGenerator
    }
    
    func parseUserMessage(message: String) -> EntityModel {
        // 1. Tokenize the user message
        let tokens = tokenize(message)
        
        // 2. Classify the user intent
        let intent = intentClassifier.classify(tokens: tokens)
        
        // 3. Extract entities from the user message
        let entities = extractEntities(tokens: tokens, intent: intent)
        
        return EntityModel(intent: intent, entities: entities)
    }
    
    func generateResponse(entity: EntityModel) -> String {
        return responseGenerator.generateResponse(intent: entity.intent, entities: entity.entities)
    }
}

// 6. Define the IntentClassifier protocol to classify the user intent
protocol IntentClassifier {
    func classify(tokens: [String]) -> Intent
}

// 7. Define the ResponseGenerator protocol to generate the chatbot response
protocol ResponseGenerator {
    func generateResponse(intent: Intent, entities: [String: String]) -> String
}