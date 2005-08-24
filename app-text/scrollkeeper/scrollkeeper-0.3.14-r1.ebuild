# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.3.14-r1.ebuild,v 1.5 2005/08/24 13:28:48 gustavoz Exp $

inherit libtool eutils

DESCRIPTION="cataloging system for documentation on open systems"
HOMEPAGE="http://scrollkeeper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="FDL-1.1 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 sparc x86"
IUSE="nls"

RDEPEND=">=dev-libs/libxml2-2.4.19
	>=dev-libs/libxslt-1.0.14
	>=sys-libs/zlib-1.1.3
	~app-text/docbook-xml-dtd-4.1.2
	>=app-text/docbook-sgml-utils-0.6.6"
DEPEND="${RDEPEND}
	 >=dev-util/intltool-0.29
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-gcc2_fix.patch
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

	insinto /etc/logrotate.d
	newins ${FILESDIR}/scrollkeeper-logrotate scrollkeeper

	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README TODO scrollkeeper-spec.txt
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
