# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jasspa-microemacs/jasspa-microemacs-20021205.ebuild,v 1.1 2004/03/14 10:54:29 usata Exp $

MY_PV=${PV:2}	# 20021205 -> 021205

DESCRIPTION="Jasspa Microemacs"
HOMEPAGE="http://www.jasspa.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
# downloaded from:
#SRC_URI="http://www.jasspa.com/release_${MY_PV}/memacros.tar.gz 
#	http://www.jasspa.com/release_${MY_PV}/me.ehf.gz
#	http://www.jasspa.com/release_${MY_PV}/mehtml.tar.gz
#	http://www.jasspa.com/release_${MY_PV}/mesrc.tar.gz 
#	http://www.jasspa.com/release_${MY_PV}/meicons.tar.gz 
#	http://www.jasspa.com/release_${MY_PV}/meicons-extra.tar.gz"
##	http://www.jasspa.com/spelling/ls_enus.tar.gz
##	http://www.jasspa.com/release_${MY_PV}/readme.jasspa_gnome

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PROVIDE=""
DEPEND="virtual/glibc
	sys-libs/ncurses
	X? ( virtual/x11 )"
# X11 might actually be optional ... but I'm not so clever yet 
RDEPEND=""

src_compile() {
	sed -i "/^COPTIMISE/s/.*/COPTIMISE = ${CFLAGS}/" linux2.gmk
	local loadpath="~/.jasspa:/usr/share/jasspa/site:/usr/share/jasspa"
	if [ "`use X`" ]
	then
		./build -p "$loadpath"
	else
		./build -t c -p "$loadpath"
	fi
	mv me me32
	cat >me <<'EOT'
#!/bin/bash
if [[ -n "$DISPLAY" ]]
then
	set +m; /usr/bin/me32 "$@"
else
	# ixon allows ctrl S to be used for searching
	stty -ixon; /usr/bin/me32 "$@"; stty ixon
fi
EOT
}

src_install() {
	dodir /usr/share/jasspa
	keepdir /usr/share/jasspa/site
	dobin me
	dobin me32
	cp -r ${S}/stagging/* ${D}/usr/share/jasspa
}
