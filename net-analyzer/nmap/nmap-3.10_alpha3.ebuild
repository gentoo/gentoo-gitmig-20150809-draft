# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.10_alpha3.ebuild,v 1.1 2002/10/23 21:03:40 vapier Exp $

IUSE="gtk gnome ipv6"

MY_P="${P/_alpha/ALPHA}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Portscanner"
SRC_URI="http://www.insecure.org/nmap/dist/${MY_P}.tgz"
HOMEPAGE="http://www.insecure.org/nmap/"
DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

src_compile() {
	use ipv6 \
		&& econf --enable-ipv6 \
		|| econf

	use gtk \
		&& make \
		|| make nmap
}

src_install() {															 
	local myinst

	# If gnome does not exist on the system, there is no need for the gnome
	# menu item.
	use gnome || myinst="${myinst} deskdir=${S}"

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		nmapdatadir=${D}/usr/share/nmap \
		install || die

	dodoc CHANGELOG COPYING HACKING README*
	cd docs
	dodoc *.txt
	dohtml *.html
}
