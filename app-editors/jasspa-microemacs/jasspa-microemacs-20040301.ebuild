# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jasspa-microemacs/jasspa-microemacs-20040301.ebuild,v 1.6 2004/08/26 11:53:59 usata Exp $

MY_PV=${PV:2}	# 20021205 -> 021205

DESCRIPTION="Jasspa Microemacs"
HOMEPAGE="http://www.jasspa.com/"
SRC_URI="http://www.jasspa.com/release_${MY_PV}/jasspa-memacros-${PV}.tar.gz
	http://www.jasspa.com/release_${MY_PV}/jasspa-mehtml-${PV}.tar.gz
	http://www.jasspa.com/release_${MY_PV}/jasspa-mesrc-${PV}.tar.gz
	http://www.jasspa.com/release_${MY_PV}/meicons-extra.tar.gz"
#	http://www.jasspa.com/release_${MY_PV}/me.ehf.gz
#	http://www.jasspa.com/release_${MY_PV}/meicons.tar.gz 
##	http://www.jasspa.com/spelling/ls_enus.tar.gz
##	http://www.jasspa.com/release_${MY_PV}/readme.jasspa_gnome

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="X"

DEPEND="virtual/libc
	sys-libs/ncurses
	X? ( virtual/x11 )"

S="${WORKDIR}/me${MY_PV}/src"

src_unpack() {
	unpack jasspa-mesrc-${PV}.tar.gz
	cd ${T}
	# everything except jasspa-mesrc
	unpack ${A/jasspa-mesrc-${PV}.tar.gz/}
}

src_compile() {
	sed -i "/^COPTIMISE/s/.*/COPTIMISE = ${CFLAGS}/" linux2.gmk
	local loadpath="~/.jasspa:/usr/share/jasspa/site:/usr/share/jasspa"
	if use X
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
	dobin me me32 || die
	dodoc ../*.txt ../change.log
	cp -r ${T}/* ${D}/usr/share/jasspa
}
