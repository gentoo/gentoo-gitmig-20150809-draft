# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.5.7.ebuild,v 1.2 2003/05/24 18:29:59 taviso Exp $

inherit eutils libtool gnome.org flag-o-matic

IUSE="python readline"

S="${WORKDIR}/${P}"
DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.gnome.org/"

DEPEND="sys-libs/zlib
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )"
 
SLOT="2"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

src_compile() {
	# Fix .la files of python site packages
	elibtoolize

	local myconf=""
	
	if [ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ]; then
		# i think the author assumes __DECC is defined only on Tru64.
		# quick fix in this patch. -taviso.
		append-flags -ieee
		epatch ${FILESDIR}/libxml2-${PV}-dec-alpha-compiler.diff
	fi

	# This breaks gnome2 (libgnomeprint for instance fails to compile with
	# fresh install, and existing) - <azarah@gentoo.org> (22 Dec 2002).
	#use zlib && myconf="--with-zlib" || myconf="--without-zlib"

	use python && myconf="${myconf} --with-python" \
		|| myconf="${myconf} --without-python" 
	use readline && myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	econf --with-zlib ${myconf} || die
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
