TARGETS_DRAFTS := draft-km-industrial-internet-requirements 
TARGETS_TAGS := 
draft-km-industrial-internet-requirements-00.md: draft-km-industrial-internet-requirements.md
	sed -e 's/draft-km-industrial-internet-requirements-latest/draft-km-industrial-internet-requirements-00/g' $< >$@
