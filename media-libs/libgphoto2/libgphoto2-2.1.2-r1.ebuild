# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.2-r1.ebuild,v 1.9 2004/02/18 14:24:17 agriffis Exp $

inherit libtool

MAKEOPTS="-j1" # or the documentation fails. bah!

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE="nls doc jpeg"

# needs >usbutils-0.11-r2 to avoid /usr/lib/libusb* conflicts with dev-libs/libusb
RDEPEND=">=dev-libs/libusb-0.1.6
	>=sys-apps/usbutils-0.11-r2
	sys-apps/hotplug
	jpeg? ( >=media-libs/libexif-0.5.9 )"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.5.9
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-norpm.patch
	epatch ${FILESDIR}/${P}-canon.patch #Closes #30880
}

src_compile() {
	elibtoolize

	local myconf

	myconf="--with-rpmbuild=/bin/false"

	use jpeg \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable doc docs`"

	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		hotplugdocdir=/usr/share/doc/${PF}/linux-hotplug \
		install || die "install failed"

	# manually move apidocs
	if [ -n "`use doc`" ]; then
		dodir /usr/share/doc/${PF}/api
		mv ${D}/usr/share/doc/libgphoto2/html/api/* ${D}/usr/share/doc/${PF}/api/
		mv ${D}/usr/share/doc/libgphoto2_port/html/api/* ${D}/usr/share/doc/${PF}/api/
	fi
	rm -rf ${D}/usr/share/doc/libgphoto2
	rm -rf ${D}/usr/share/doc/libgphoto2_port

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	insinto /etc/hotplug/usb
	newins ${S}/packaging/linux-hotplug/usbcam.console usbcam
	chmod +x ${D}/etc/hotplug/usb/usbcam

	HOTPLUG_USERMAP="${D}/etc/hotplug/usb/usbcam.usermap"
	${D}/usr/lib/libgphoto2/print-usb-usermap >> ${HOTPLUG_USERMAP}

	# additional canon powershot usb ids. james <zeurx@hotmail.com> (#24988)
	doins ${FILESDIR}/canon.powershot.usermap
}
