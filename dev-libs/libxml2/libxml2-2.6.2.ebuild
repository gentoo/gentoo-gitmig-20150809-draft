# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.6.2.ebuild,v 1.4 2004/02/17 10:45:09 kumba Exp $

inherit eutils libtool gnome.org flag-o-matic

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"
LICENSE="MIT"

IUSE="python readline ipv6"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ia64"

DEPEND="sys-libs/zlib
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )"

src_compile() {

	# Please do not remove, as else we get references to PORTAGE_TMPDIR
	# in /usr/lib/python?.?/site-packages/libxml2mod.la among things.
	elibtoolize

	# filter seemingly problematic CFLAGS (#26320)
	filter-flags -fprefetch-loop-arrays -funroll-loops

	# USE zlib support breaks gnome2
	# (libgnomeprint for instance fails to compile with
	# fresh install, and existing) - <azarah@gentoo.org> (22 Dec 2002).

	econf --with-zlib \
		`use_with python` \
		`use_with readline` \
		`use_enable ipv6` || die

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

	dodoc AUTHORS Copyright ChangeLog INSTALL NEWS README TODO

}

pkg_postinst() {

	# need an XML catalog, so no-one writes to a non-existent one
	CATALOG=/etc/xml/catalog
	# we dont want to clobber an existing catalog though,
	# only ensure that one is there
	# <obz@gentoo.org>
	if [ ! -e ${CATALOG} ]; then
		[ -d /etc/xml ] || mkdir /etc/xml
		/usr/bin/xmlcatalog --create > ${CATALOG}
		einfo "Created XML catalog in ${CATALOG}"
	fi

}

