module ReviewsHelper

    def display_header(review)
        if params[:book_id]
            content_tag(:h1, "Add a Review for #{review.book.name} -  #{review.book.category.name}")
        else
          content_tag(:h1, "Create a review")
        end
      end
end
