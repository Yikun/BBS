#!/bin/bash

set -e  # exit immediately if a simple command returns a non-zero status

cd "$HOME/propagation/3.17"

. ./config.sh

BBS_OUTGOING_DIR="/home/biocbuild/public_html/BBS/$BIOC_VERSION/data-annotation/OUTGOING"
R_EXPR="source('/home/biocbuild/BBS/utils/list.old.pkgs.R')"
PROPAGATION_R_EXPR="source('/home/biocbuild/BBS/utils/copyPropagatableFiles.R')"
PROPAGATION_DB_FILE="$BBS_OUTGOING_DIR/../PROPAGATION_STATUS_DB.txt"

REPOS_ROOT="$HOME/PACKAGES/$BIOC_VERSION/data/annotation"
SRC_CONTRIB="$REPOS_ROOT/src/contrib"
WIN_CONTRIB="$REPOS_ROOT/bin/windows/contrib/$R_VERSION"
MAC_CONTRIB="$REPOS_ROOT/bin/macosx/contrib/$R_VERSION"

if [ ! -f "$PROPAGATION_DB_FILE" ]; then
        echo "ERROR: $PROPAGATION_DB_FILE not found. Did postrun.sh run?"
        exit 1
fi

update_repo()
{
	working_dir="$1"
	outgoing_subdir="$BBS_OUTGOING_DIR/$2"
	fileext="$3"
	cd "$working_dir"
	if [ "$?" != "0" ]; then
		exit 1
	fi
#	cp --no-clobber --verbose "$outgoing_subdir"/*.$fileext .
	$Rscript -e "$PROPAGATION_R_EXPR; try(copyPropagatableFiles('$outgoing_subdir', '$fileext', '$PROPAGATION_DB_FILE', '$REPOS_ROOT'))"
	$Rscript -e "$R_EXPR; oldpkgs <- list.old.pkgs(suffix='.$fileext'); removed <- file.remove(oldpkgs); names(removed) <- oldpkgs; removed"
}

echo ""
echo "========================================================================"
/bin/date
echo "------------------------------------------------------------------------"

echo ""
echo "Updating $BIOC_VERSION/data/annotation repo with source packages..."
update_repo "$SRC_CONTRIB" "source" "tar.gz"

echo ""

## FIXME: Why aren't manuals propagated based on the same criteria as source
## packages? Looks like the former are propagated based on their timestamps
## only (see below) while for source packages we use the more refined
## propagation criteria. This can easily lead to situations where the manual
## available on a package landing page doesn't match the version of the
## source package. Not good!
MANUALS_DEST="$REPOS_ROOT/manuals"
MANUALS_SRC="$BBS_OUTGOING_DIR/manuals"
echo "Updating $BIOC_VERSION/data/annotation repo with reference manuals..."
for i in `ls $MANUALS_SRC`; do
	pkg=`echo $i| awk '{split($0,a,".pdf"); print(a[1])}'`
	mkdir -p $MANUALS_DEST/$pkg/man
	cp --update --verbose $MANUALS_SRC/$i $MANUALS_DEST/$pkg/man
done

echo "DONE."
exit 0
