# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bitkeeper/bitkeeper-3.0.1.ebuild,v 1.3 2003/02/17 04:05:58 vapier Exp $

DESCRIPTION="scalable configuration management system"
HOMEPAGE="http://www.bitkeeper.com/"
SRC_URI="x86? ( bk-3.0.1-x86-glibc22-linux.bin )
	ppc? ( bk-3.0.1-powerpc-glibc21-linux.bin )
	sparc? ( bk-3.0.1-sparc-glibc21-linux.bin )
	alpha? ( bk-3.0.1-alpha-glibc21-linux.bin )
	arm? ( bk-3.0.1-arm-glibc21-linux.bin )
	hppa? ( bk-3.0.1-hppa-glibc22-linux.bin )"

SLOT="0"
LICENSE="BKL"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/tcl-8.3.3
	X? ( >=dev-lang/tk-8.3.3 )"

RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	eerror "You need to perform the following steps to install this package:"
	eerror " - Sign up at ${HOMEPAGE}"
	eerror " - Check your mail and visit the download location"
	eerror " - Download ${A} and place it in ${DISTDIR}"
	eerror " - emerge this package again"
}

src_unpack() {
	cp ${DISTDIR}/${A} ${S}/${A}
	chmod 755 ${S}/${A}
	echo 'none' | ${S}/${A} > ${S}/output 2>/dev/null
	installer=`sed -n -e "s/Installation script: \(.*\)/\1/p" ${S}/output`
	archive=`sed -n -e "s/Gzipped tar archive: \(.*\)/\1/p" ${S}/output`
	mv ${installer} ${S}/installer
	mv ${archive} ${S}/archive
}

src_install() {
	dodir /opt /etc/env.d
	tar -xzpf ${S}/archive
	mv bitkeeper ${D}/opt/${P}
	chown -R root:root ${D}/opt/${P}
	chmod -R u+w,go-w ${D}/opt/${P}
	cat <<EOF >${D}/etc/env.d/10bitkeeper
PATH=/opt/${P}
ROOTPATH=/opt/${P}
MANPATH=/opt/${P}/man
EOF
}
