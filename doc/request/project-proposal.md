---
output: odt_document
---

### A1. Project title (200 characters):

### A2. Research question(s) and aim(s) (up to 5000 characters or 200 words):

The overarching goal for this project is to better characterise, quantify, and
understand the impact that early life conditions have on adult metabolic
capacity and for the risk for type 2 diabetes (T2D) and cardiovascular disease
(CVD) in adulthood. To that aim we have two objectives:

1. To determine the association of early childhood adversity (using adult leg
length as a biomarker) on various metabolic functions:
    - Adult liver function (using markers of fat and inflammation from the MRI
    images).
    - Distribution of body fat, whether fat is stored primarily in the trunk or in
    the peripheral tissues (using DXA and bioimpediance measures).
    - Adult kidney function (using urinary markers).
    - Adult blood biomarkers (fasting glucose, lipid measures) {{confirm with what
    they have measured}}.
    - {{genetic risk prediction scores...? Need help with this one Daniel}}

2. To determine the mediating pathways that adult metabolic capacity has between
exposure to early childhood adversity and risk for T2D and CVD.

> The majority of applications to UK Biobank are for data only. As such, the first two questions we ask are whether your application involves access to samples or re-contact as this will require some additional information and as is set out in the Access Procedures (our data are not depletable, but our samples and re-contact opportunities are depletable) recontact/sample applications are assessed to a different (more exacting) standard.

Does your project require biological samples? **No**

Does your project require UK Biobank to re-contact participants: **No**

### A3. The background and scientific rationale of the proposed research project in general (up to 5000 characters or 300 words): 

Early life adversity is known to influence the risk for chronic cardiometabolic
diseases such as type 2 diabetes (T2D) and cardiovascular disease (CVD) later in
adult life. Early life, typically defined as from conception until early childhood (~6
years), is a period characterised by substantial growth and development
[@Hales2001;@Gluckman2007]. Exposure to various adverse conditions during this
period, such as poverty, war, or malnutrition, as well as less extreme adverse
conditions, such as neglect, loss of a parent, or childhood conflict
[@Maniam2014a;@Thomas2008a;@Rich-Edwards2010a], set individuals on a higher
disease risk trajectory lasting throughout all of adult life
[@Hales2001;@Li2011a;@Clarkin2012;@McEniry2013;@Berens2017a].

Preventing these adversities is of utmost importance. Equally important is
identifying and managing the risk of disease in those already exposed.
A crucial step to developing evidenced-based solutions to mitigate risk is
in understanding which pathophysiological mechanisms does early life adversity
affect and subsequently contribute to the development of cardiometabolic
disease. Limited data exists that have investigated this area. A few studies
suggest that lower early life socioeconomic position and other indirect
indicators of early life conditions associates with a lower metabolic capacity
[@Solis2016a;@Solis2015a;@Robertson2014a;@Kumari2012a;@Gruenewald2012a]. There
is very limited knowledge on how early life adversity mediates its effect on
later disease through adult metabolic capacity (such as through lipid
metabolism, inflammatory processes, and/or glucose regulation) [@Berens2017a].

### A4. A brief description of the method(s) to be used (up to 5000 characters or 300 words): 

(including fat, inflammation, iron, and general image) using MRI images

For objective one, we will run standard regression techniques for each of the
sub-objectives.

For objective two, we will using a form of causal structure learning and
mediation analysis 

### A5. The type and size of dataset required (e.g., case-control subset, men only, imaging data only, whole cohort, etc.) (up to 5000 characters or 100 words):

Whole cohort, MRI imaging, biomarker data,

### A6. The expected value of the research (taking into account the public interest requirement) (up to 5000 characters or 100 words): 

The rise of the digital era and of big data has presented a number of
challenges and opportunities to modern epidemiology. Historically it was nearly
impossible or at least extremely difficult to answer meaningful questions about
the role of early life factors on later disease, but now there are many valuable
datasets available to answer these questions. However, the analytical expertise
and tools are still lacking. Complex data such as from -omics approaches are
increasingly available in cohort and trial studies and can be combined with
other databases such as with the Danish register databases. From the analytic
perspective, current pathway techniques and statistical algorithms need either
a high degree of knowledge and supervision as they need single pre-specified
DAGs, which are not realistic at such level of complexity and dimensionality in
the data. This is a major limitation to these techniques when used on high
dimensional data or if the hypothesised direction of the pathway is
misspecified. The innovative analytical tool from this project that I will
bundle as an R software package, to then disseminate, will fully exploit complex
datasets for etiological research and I will apply this novel tool to *explain*
the links between adversity in early life and chronic disease incidence. My
results will provide etiological insight into how exposure to adversity in early
life modifies adult metabolic capacity, which may subsequently reveal a specific
metabolic patterns (e.g. more circulating long-chain, saturated fatty acids) or
more (or less) of specific metabolites (e.g. less n-3 fatty acids) that
contributes to T2D. These changes in metabolism could be used as targets for
individual level prevention or management in those exposed to adversity in early
life, for instance by aggressively managing levels of specific circulating
lipids.


These forms of adversity are much more common in many
EU countries, with nearly 30% of children in EU experiencing some form of mental
or physical abuse [@Europe2014a].

### A7. Please provide up to 6 keywords which best summarise your proposed research project:

### A8. Please provide a lay summary of your research project in plain English, stating the aims, scientific rationale, project duration and public health impact (up to 5000 characters or 400 words):

Adverse conditions during early life is known to influence the risk for
metabolic diseases like type 2 diabetes (T2D) in adulthood. However, it is largely
unknown which metabolic mechanisms mediate the link between early life adversity
and adult T2D. Which interventions in adulthood are most likely to mitigate T2D
risk in those exposed to adversity is dependent on this knowledge. Studying
early life in sufficient detail is difficult as life course data with adequate
metabolic data must be collected and the appropriate, though complex,
statistical techniques, along with the expertise to use them, is needed for
making valid inferences. Two recent advances now make it possible to research
these topics. The ability to *link* cohort studies that have metabolic data with
national register databases that have information from early to end of life
provides the appropriately detailed life-course data. A recent analytical
approach, called *causal structure learning*, provides the statistical process
for working with this data. My **aims** are to determine how specific early life
conditions affect T2D risk and how the metabolic pathways mediate early life adversity
with higher risk for T2D, and to convert a recent integrative pathway *algorithm*
(NetCoupler), capable of analysing high dimensional -omics data, into a reusable
software package. I will link Denmark's unique national registries with multiple
Danish cohorts, deploy and apply the NetCoupler-algorithm, and collaborate with
national and international groups to achieve these aims. The project's software
output will create a tool for researchers working on similar research topics
while the findings will give insight into how adversity modifies metabolism that
then affects T2D risk. With these insights, more effective public health
strategies can be created for T2D prevention and more precise clinical decisions
can be made for T2D management in those exposed to early life adversity.

### A9. Will the research project result in the generation of any new data fields derived from existing complex datasets, such as imaging, accelerometry, electrocardiographic, linked healthcare data, etc, which might be of significant utility to other researchers: 

### A10. What is the estimated duration of your project, in months? If you consider (because for example the project is one involving the generation of hypotheses) that it would be difficult to set a fixed end point, we are prepared to consider a rolling 3-year period (during which annual updates are required):

2 years..?

Please note that you are expected to publish (or to make publicly available) your results and return to UK Biobank:

- any important derived variables
- a description of the methods used to generate them
- the underlying syntax/code used to generate the main results of the paper, and
- a short layman's description that summarises your findings.

These should be provided within six months of each publication or within 12 months of the project end date (whichever comes first). We also ask that you send us a copy of your accepted manuscript at least two weeks prior to publication and alert us if there are any ethical or contentious issues surrounding the findings. 

### B. Selection of data-fields

- Blood counts
- Urine assays
- Body size measures
- Abdominal MRI (liver images)
- DXA (region specific bone and body composition)
- Impediance measures
- Early life factors
- Indices of Multiple Deprivation
- Genotype/genes
