# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.3.9-r1.ebuild,v 1.3 2002/08/16 02:42:02 murphy Exp $

inherit libtool

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

KEYWORDS="x86 ppc sparc sparc64"

S=${WORKDIR}/${P}
DESCRIPTION="Scrollkeeper"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
http://telia.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz
http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz
http://belnet.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://scrollkeeper.sourceforge.net"
SLOT="0"
LICENSE="FDL-1.1 LGPL-2.1"

RDEPEND=">=dev-libs/libxml2-2.4.19
	>=dev-libs/libxslt-1.0.14
	>=sys-libs/zlib-1.1.3
	>=app-text/docbook-xml-dtd-4.1.2-r2
	>=app-text/docbook-sgml-utils-0.6.6"

DEPEND="${RDEPEND}
	 >=dev-util/intltool-0.17
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	cd ${S}/extract/dtds
	patch -p0 < ${FILESDIR}/${P}.diff || die
}
	
src_compile() {
	elibtoolize

	local myconf=""

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	# hack around some to make sure we find the libxml2 includes. odd bug.
#	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
				
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
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
	echo ">>> Installing catalog..."
	${ROOT}/usr/bin/xmlcatalog --noout --add "public" \
		"-//OMF//DTD Scrollkeeper OMF Variant V1.0//EN" \
		"`echo "${ROOT}/usr/share/xml/scrollkeeper/dtds/scrollkeeper-omf.dtd" |sed -e "s://:/:g"`" \
		${ROOT}/etc/xml/catalog
	echo ">>> Rebuilding Scrollkeeper database..."	
	scrollkeeper-rebuilddb -q -p ${ROOT}/var/lib/scrollkeeper
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update -v &>${T}/foo
}

pkg_postrm() {
	if [ ! -x ${ROOT}/usr/bin/scrollkeeper-config ]
	then
		# SK is being removed, not upgraded.
		# Remove all generated files
		einfo ">>> Cleaning up ${ROOT}/var/lib/scrollkeeper..."
		rm -rf ${ROOT}/var/lib/scrollkeeper
		rm -rf ${ROOT}/var/log/scrollkeeper.log
		rm -rf ${ROOT}/var/log/scrollkeeper.log.1
		${ROOT}/usr/bin/xmlcatalog --noout --del \
			"${ROOT}/usr/share/xml/scrollkeeper/dtds/scrollkeeper-omf.dtd" \
			${ROOT}/etc/xml/catalog

		einfo ">>> Scrollkeeper ${PV} unmerged, if you removed the package"
		einfo ">>> you might want to clean up /var/lib/scrollkeeper."
	fi
}

