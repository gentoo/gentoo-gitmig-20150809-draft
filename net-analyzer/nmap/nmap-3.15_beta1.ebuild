# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.15_beta1.ebuild,v 1.2 2003/02/25 14:10:31 gmsoft Exp $

inherit gcc

MY_P="${P/_beta/BETA}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="utility for network exploration or security auditing"
SRC_URI="http://www.insecure.org/nmap/dist/${MY_P}.tgz"
HOMEPAGE="http://www.insecure.org/nmap/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"
IUSE="gtk gnome"

DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	# fix header
	if [ `gcc-major-version` -eq 3 ] ; then
		cp nbase/nbase.h nbase/nbase.h.old
		sed -e 's:char \*strcasestr://:' \
			nbase/nbase.h.old > nbase/nbase.h
	fi

	econf `use_with gtk nmapfe` || die
	emake || die
}

src_install() {
	einstall \
		nmapdatadir=${D}/usr/share/nmap \
		install \
		|| die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG COPYING HACKING README* docs/*.txt
	dohtml docs/*.html
}
