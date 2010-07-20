module Freelancer
  module Util
    #Convert array parameters to hash, using field list
    #
    #def mymethod *args
    #   options = fill_args [:param1,:param2,:param3],[:param1], *args
    #....
    #
    #mymethod 1,2,3                 => {:param1=>1,:param2=>2,param3=>3}
    #mymethod                       => exception, Required key not found
    #mymethod 1,"x"                 => {:param1=>1,:param2=>"x"}
    #mymethod :param1=>"y"          => {:param1=>"y"}
    #mymethod :param1=>1,:param2=>2 => {:param1=>1,:param2=>2}
    #
    #fields   Required,the field list
    #require  Required,the required field list (maybe empty array)
    #arguments
    def fill_args fields,required, *arguments
      options={}
      arguments.each_index do |index|
        if arguments[index].is_a? Hash
          options.merge! arguments[index]
        else
          options[fields[index]]=arguments[index]
        end
      end
      required.each do |needed|
        if !options.key? needed
          raise "Required key not found"
        end
      end
      return options
    end
  end
end
