# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openais/openais-1.1.3.ebuild,v 1.1 2010/06/26 16:32:39 xarthisius Exp $

EAPI="2"

inherit autotools base

DESCRIPTION="Open Application Interface Specification cluster framework"
HOMEPAGE="http://www.openais.org/"
SRC_URI="ftp://ftp:${PN}.org@${PN}.org/downloads/${P}/${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-cluster/corosync"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( "${S}/AUTHORS" "${S}/README.amf" )

src_prepare() {
	# respect CFLAGS
	sed -i -e "s/\$OPT_CFLAGS \$GDB_FLAGS//" configure.ac || die
	# respect LDFLAGS
	sed -i -e "s/\$(CFLAGS) -shared/\$(CFLAGS) \$(LDFLAGS) -shared/" \
		services/Makefile.am || die
	# don't install docs
	sed -i -e "/^dist_doc/d" Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}
		--localstatedir=/var
}

src_install() {
	base_src_install
	rm -rf "${D}"/etc/init.d/openais || die
}
