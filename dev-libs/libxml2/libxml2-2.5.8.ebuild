# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.5.8.ebuild,v 1.2 2003/07/12 09:22:22 aliz Exp $

inherit eutils libtool gnome.org

IUSE="python readline ipv6"

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

DEPEND="sys-libs/zlib
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )"
 
SLOT="2"
LICENSE="MIT"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

src_compile() {
	elibtoolize

        if [ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ]; then
                # i think the author assumes __DECC is defined only on Tru64.
                # quick fix in this patch. -taviso.
                append-flags -ieee
                epatch ${FILESDIR}/libxml2-${PV}-dec-alpha-compiler.diff
        fi

	# USE zlib support breaks gnome2 (libgnomeprint for instance fails to compile with
	# fresh install, and existing) - <azarah@gentoo.org> (22 Dec 2002).

	econf --with-zlib `use_with python` `use_with readline` `use_enable ipv6` || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/example \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		EXAMPLES_DIR=/usr/share/doc/${PF}/example \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
