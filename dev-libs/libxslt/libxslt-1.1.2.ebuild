# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.2.ebuild,v 1.3 2004/02/09 16:49:04 gustavoz Exp $

inherit libtool gnome.org

IUSE="python"
DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ~ppc sparc ~alpha hppa ~amd64 ~ia64"

DEPEND=">=dev-libs/libxml2-2.6.3
	python? ( dev-lang/python )"

src_compile() {

	elibtoolize

	econf $(use_with python) || die "configure failed"

	emake || die "make failed"

}

src_install() {

	make DESTDIR=${D} \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/example \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		EXAMPLES_DIR=/usr/share/doc/${PF}/example \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die "install failed"

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO

}
