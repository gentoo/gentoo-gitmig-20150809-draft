# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.6.ebuild,v 1.4 2005/06/28 22:55:38 agriffis Exp $

inherit libtool eutils

DESCRIPTION="Library that implements support for numerous digital cameras"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ia64 ~ppc64 ~alpha"
IUSE="nls doc exif nousb"

# needs >usbutils-0.11-r2 to avoid /usr/lib/libusb*
# conflicts with dev-libs/libusb
RDEPEND="!nousb? (
		>=dev-libs/libusb-0.1.8
		>=sys-apps/usbutils-0.11-r2
		sys-apps/hotplug
	)
	exif? ( >=media-libs/libexif-0.5.9 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set CAMERAS
# environment to a comma-separated list (no spaces) of drivers that
# you want to build.
IUSE_CAMERAS="adc65 agfa-cl20 aox barbie canon casio digita dimera directory enigma13 fuji gsmart300 iclick jamcam jd11
kodak konica largan mars minolta mustek panasonic pccam300 pccam600 polaroid ptp2 ricoh samsung
sierra sipix smal sonydscf1 sonydscf55 soundvision spca50x sq905 stv0674 stv0680 sx330z toshiba"

pkg_setup() {
	if [ -z "${CAMERAS}" ] ; then
		ewarn "All camera drivers will be built since you did not specify"
		ewarn "via the CAMERAS variable what camera you use."
		einfo "libgphoto2 supports: all ${IUSE_CAMERAS}"
	fi
	echo
	use jpeg && ewarn "For 'exif' support, you need to set USE=exif"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.2-norpm.patch
}

src_compile() {
	local cameras
	local cam
	for cam in ${CAMERAS} ; do
		has ${cam} ${IUSE_CAMERAS} && cameras="${cameras},${cam}"
	done
	[ -z "${cameras}" ] \
		&& cameras="all" \
		|| cameras="${cameras:1}"
	einfo $cameras

	elibtoolize

	local myconf

	myconf="--with-rpmbuild=/bin/false"
	myconf="--with-drivers=${cameras}"
	use exif \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable doc docs`"
	econf ${myconf} || die "econf failed"
	# or the documentation fails.
	emake -j1 || die "make failed"
}

src_install() {
	if use !nousb; then
	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		hotplugdocdir=/usr/share/doc/${PF}/linux-hotplug \
		install || die "install failed"
	else
	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		install || die "install failed"
	fi

	# manually move apidocs
	if use doc; then
		dodir /usr/share/doc/${PF}/api
		mv ${D}/usr/share/doc/libgphoto2/html/api/* ${D}/usr/share/doc/${PF}/api/
		mv ${D}/usr/share/doc/libgphoto2_port/html/api/* ${D}/usr/share/doc/${PF}/api/
	fi
	rm -rf ${D}/usr/share/doc/libgphoto2
	rm -rf ${D}/usr/share/doc/libgphoto2_port

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	if use !nousb; then
		insinto /etc/hotplug/usb
		newins ${S}/packaging/linux-hotplug/usbcam.console usbcam
		chmod +x ${D}/etc/hotplug/usb/usbcam
	fi
}

pkg_postinst() {
	if use !nousb; then
		einfo "Generating usbcam-gphoto2.usermap .."
		HOTPLUG_USERMAP="/etc/hotplug/usb/usbcam-gphoto2.usermap"
		if [ -x ${ROOT}/usr/$(get_libdir)/libgphoto2/print-usb-usermap ]; then
			echo "# !!! DO NOT EDIT THIS FILE !!! This file is automatically generated." > ${ROOT}/${HOTPLUG_USERMAP}
			echo "# Put your custom entries in /etc/hotplug/usb/usbcam.usermap" >> ${ROOT}/${HOTPLUG_USERMAP}
			${ROOT}/usr/$(get_libdir)/libgphoto2/print-usb-usermap >> ${ROOT}/${HOTPLUG_USERMAP}
		else
			eerror "Unable to find ${ROOT}/usr/$(get_libdir)/libgphoto2/print-usb-usermap"
			eerror "and therefore unable to generate hotplug usermap."
			eerror "You will have to manually generate it by running:"
			eerror " /usr/$(get_libdir)/libgphoto2/print-usb-usermap > ${HOTPLUG_USERMAP}"
		fi
	fi
}
