# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.0.30-r1.ebuild,v 1.2 2003/06/24 14:48:06 agriffis Exp $

inherit libtool gnome.org

IUSE="python"
DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc sparc alpha ~hppa"

RDEPEND=">=dev-libs/libxml2-2.5.6
	python? ( dev-lang/python )"

DEPEND="${RDEPEND}
	dev-lang/perl"

src_compile() {
	elibtoolize

	local myconf

	use python && myconf="--with-python" || myconf="--without-python"

	econf ${myconf} || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/example \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		EXAMPLES_DIR=/usr/share/doc/${PF}/example \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
}
