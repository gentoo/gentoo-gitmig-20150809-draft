# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.6.18.ebuild,v 1.1 2005/03/20 23:51:36 joem Exp $

inherit libtool gnome.org flag-o-matic gnuconfig

DESCRIPTION="Version 2 of the library to manipulate XML files"
HOMEPAGE="http://www.xmlsoft.org/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="python readline ipv6"

RDEPEND="sys-libs/zlib
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	hppa? ( >=sys-devel/binutils-2.15.92.0.2 )"

src_unpack() {

	unpack ${A}
	gnuconfig_update ${S}

}

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
		$(use_with python) \
		$(use_with readline) \
		$(use_enable ipv6) || die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO

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
