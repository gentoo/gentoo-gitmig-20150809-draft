# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.3.14.ebuild,v 1.1 2004/02/05 23:01:04 spider Exp $

IUSE="nls"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Scrollkeeper"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://scrollkeeper.sourceforge.net"

SLOT="0"
LICENSE="FDL-1.1 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

RDEPEND=">=dev-libs/libxml2-2.4.19
	>=dev-libs/libxslt-1.0.14
	>=sys-libs/zlib-1.1.3
	=app-text/docbook-xml-dtd-4.1.2*
	>=app-text/docbook-sgml-utils-0.6.6"

DEPEND="${RDEPEND}
	 >=dev-util/intltool-0.17
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0< ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	elibtoolize

	local myconf=""

	use nls || {
		myconf="${myconf} --disable-nls"
		# Not existing can cause ./configure to fail in some cases.
		touch ${S}/intl/libintl.h
	}


	econf \
		--localstatedir=/var \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL TODO COPYING* ChangeLog README NEWS
}

pkg_preinst() {
	if [ -d ${ROOT}/usr/share/scrollkeeper/Templates ]
	then
		rm -rf ${ROOT}/usr/share/scrollkeeper/Templates
	fi
}

pkg_postinst() {
	einfo "Installing catalog..."
	${ROOT}/usr/bin/xmlcatalog --noout --add "public" \
		"-//OMF//DTD Scrollkeeper OMF Variant V1.0//EN" \
		"`echo "${ROOT}/usr/share/xml/scrollkeeper/dtds/scrollkeeper-omf.dtd" |sed -e "s://:/:g"`" \
		${ROOT}/etc/xml/catalog
	einfo "Rebuilding Scrollkeeper database..."
	scrollkeeper-rebuilddb -q -p ${ROOT}/var/lib/scrollkeeper
	einfo "Updating Scrollkeeper database..."
	scrollkeeper-update -v &>${T}/foo
}

pkg_postrm() {
	if [ ! -x ${ROOT}/usr/bin/scrollkeeper-config ]
	then
		# SK is being removed, not upgraded.
		# Remove all generated files
		einfo "Cleaning up ${ROOT}/var/lib/scrollkeeper..."
		rm -rf ${ROOT}/var/lib/scrollkeeper
		rm -rf ${ROOT}/var/log/scrollkeeper.log
		rm -rf ${ROOT}/var/log/scrollkeeper.log.1
		${ROOT}/usr/bin/xmlcatalog --noout --del \
			"${ROOT}/usr/share/xml/scrollkeeper/dtds/scrollkeeper-omf.dtd" \
			${ROOT}/etc/xml/catalog

		einfo "Scrollkeeper ${PV} unmerged, if you removed the package"
		einfo "you might want to clean up /var/lib/scrollkeeper."
	fi
}
