# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.6.ebuild,v 1.7 2004/11/10 03:07:30 vapier Exp $

inherit libtool gnome.org python

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 ~sparc ~x86"
IUSE="python"

DEPEND=">=dev-libs/libxml2-2.6.8
	python? ( dev-lang/python )"

src_compile() {
	elibtoolize
	econf $(use_with python) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README NEWS TODO
}
