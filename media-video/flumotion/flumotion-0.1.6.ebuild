# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/flumotion/flumotion-0.1.6.ebuild,v 1.1 2005/03/25 00:25:19 zaheerm Exp $

inherit eutils

DESCRIPTION="Flumotion Streaming server"
HOMEPAGE="http://www.fluendo.com"
SRC_URI="http://www.flumotion.net/src/flumotion/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc ~amd64"
IUSE="v4l speex jpeg dv"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2
	>=media-libs/gstreamer-0.8.9-r2
	>=media-libs/gst-plugins-0.8.8
	>=media-plugins/gst-plugins-gnomevfs-0.8.8
	v4l? ( >=media-plugins/gst-plugins-v4l-0.8.8 )
	>=media-plugins/gst-plugins-ogg-0.8.8
	>=media-plugins/gst-plugins-theora-0.8.8
	>=media-plugins/gst-plugins-vorbis-0.8.8
	>=media-plugins/gst-plugins-libpng-0.8.8
	speex? ( >=media-plugins/gst-plugins-speex-0.8.8 )
	dv? ( >=media-plugins/gst-plugins-dv-0.8.8
	      >=media-plugins/gst-plugins-raw1394-0.8.8 )
	>=dev-python/pygtk-2.4.0
	>=dev-python/gst-python-0.8.1
	>=dev-python/twisted-1.3.0
	dev-python/imaging
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	"

DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  LICENCE.Flumotion LICENCE.GPL \
	  NEWS README TODO"

src_compile() {
	econf --localstatedir=/var || die

	emake || die

}

src_install() {
	einstall

	dodir /etc/flumotion
	dodir /etc/flumotion/managers
	dodir /etc/flumotion/managers/default
	dodir /etc/flumotion/managers/default/flows
	dodir /etc/flumotion/workers

	insinto /etc/flumotion/managers/default/flows
	cd ${S}/conf
	doins managers/default/flows/ogg-test-theora.xml
	insinto /etc/flumotion/managers/default
	doins managers/default/planet.xml
	insinto /etc/flumotion/workers
	doins workers/default.xml

	insinto /etc/flumotion
	doins default.pem
	exeinto /etc/init.d
	newexe ${FILESDIR}/flumotion-init flumotion

	keepdir /var/run/flumotion
	keepdir /var/log/flumotion
}

# borrowed from jboss ebuild
without_error() {
	$@ &>/dev/null || true
}

pkg_postinst() {
	if ! enewgroup flumotion || ! enewuser flumotion -1 /bin/false /usr/share/flumotion flumotion,audio,video,sys; then
		die "Unable to add flumotion user and flumotion group."
	fi

	for dir in /usr/share/flumotion /var/log/flumotion /var/run/flumotion; do
		chown -R flumotion:flumotion ${dir}
		chmod -R 755 ${dir}
	done
}
