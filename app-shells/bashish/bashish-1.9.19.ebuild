# Copyright 2003 Thomas Eriksson.
#
# Distributed under the terms of the GNU General Public License v2
#
# Suggestions for improvements are mostly welcome, the sandbox were angry
# with my home-brewn installer

S=${WORKDIR}/${P}
DESCRIPTION="Text console theme engine"
HOMEPAGE="http://bashish.sourceforge.net"
SRC_URI="mirror://sourceforge/bashish/${P}.tar.gz"
SLOT=0

LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc"


src_install() {
	into /usr
	printf "\
#!/bin/sh
export BASHISH_USERDIR=\$HOME/.bashish/
export BASHISHDIR=/usr/share/bashish/
test -z "\$BASHISH_DISABLEUSERMODE" && if test -f \$BASHISH_USERDIR/modules/sh/usermode/main;then
. \$BASHISH_USERDIR/modules/sh/usermode/main
else
. \$BASHISHDIR/modules/sh/usermode/main
fi

" 1> bashish

	printf "\
#!bashish.conf
THEME="gentoo"
DEFAULT_TERMINAL=""
DEFAULT_SHELL=""
" 1> bashish-root/modules/sh/conf/bashish.conf

	dobin bashish
	
	## create documents
	for i in bashish-root/doc/* ; do
		test -f $i && dodoc $i
	done

	cd bashish-root

	dodir /usr/share/bashish
	
	## create all directories
	for i in $(find . -type d) ; do
		dodir /usr/share/bashish/$i
	done

	## copy all files
	for i in $(find . -type f) $(find . -type l); do
		cp -d $i ${D}/usr/share/bashish/$i
	done

}
