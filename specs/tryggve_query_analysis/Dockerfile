

FROM azab/rmd-tidyverse:test



# additional R packages

RUN R -e "install.packages('pracma')"
RUN R -e "install.packages('stringr')"

ADD . /
