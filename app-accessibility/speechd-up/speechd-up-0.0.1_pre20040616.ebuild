# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd-up/speechd-up-0.0.1_pre20040616.ebuild,v 1.3 2004/06/25 16:02:10 vapier Exp $

ECVS_SERVER="cvs.freebsoft.org:/var/lib/cvs"
ECVS_MODULE="speechd-up"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
inherit cvs eutils libtool

DESCRIPTION="speechup screen reader with software synthesis"
HOMEPAGE="http://www.freebsoft.org/speechd-up"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	aclocal || die
	autoconf || die
	autoheader || die
	automake -a || die
	automake || die
	econf || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	einstall || die
	exeinto /etc/init.d
	newexe ${FILESDIR}/speechd-up.rc speechd-up
	dodoc README NEWS BUGS
}
