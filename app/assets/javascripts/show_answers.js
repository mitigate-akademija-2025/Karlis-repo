document.addEventListener("turbo:load", function() {
  document.querySelectorAll(".question-type-select").forEach(function(select) {
    function toggleAnswers() {
      const answersFields = select.closest(".nested-fields").querySelector(".answers-fields");
      if (select.value === "multiple_choice" || select.value === "true_false") {
        answersFields.style.display = "";
      } else {
        answersFields.style.display = "none";
      }
    }
    select.addEventListener("change", toggleAnswers);
    toggleAnswers();
  });
});