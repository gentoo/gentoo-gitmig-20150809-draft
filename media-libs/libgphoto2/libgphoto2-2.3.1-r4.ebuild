# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.3.1-r4.ebuild,v 1.3 2007/03/24 18:34:55 zzam Exp $

# TODO
# 1. Track upstream bug --disable-docs does not work.
#	http://sourceforge.net/tracker/index.php?func=detail&aid=1643870&group_id=8874&atid=108874
# 2. Track upstream bug udevscriptdir does not work.
#	http://sourceforge.net/tracker/index.php?func=detail&aid=1646520&group_id=8874&atid=108874
#	http://sourceforge.net/tracker/index.php?func=detail&aid=1648346&group_id=8874&atid=108874
# 3. Track upstream bug regarding rpm usage.
#	http://sourceforge.net/tracker/index.php?func=detail&aid=1643813&group_id=8874&atid=358874

inherit eutils multilib

DESCRIPTION="Library that implements support for numerous digital cameras"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="nls doc exif hal kernel_linux"
RESTRICT="test"

# By default, drivers for all supported cameras will be compiled.
# If you want to only compile for specific camera(s), set CAMERAS
# environment to a space-separated list (no commas) of drivers that
# you want to build.
IUSE_CAMERAS="adc65 agfa-cl20 aox barbie canon casio clicksmart310 digigr8 digita
dimera directory enigma13 fuji gsmart300 hp215 iclick jamcam jd11 kodak
konica largan lg_gsm mars minolta mustek panasonic pccam300 pccam600
polaroid ptp2 ricoh samsung sierra sipix smal sonix sonydscf1 sonydscf55
soundvision spca50x sq905 stv0674 stv0680 sx330z template toshiba"

for camera in ${IUSE_CAMERAS}; do
	IUSE="${IUSE} cameras_${camera}"
done

RDEPEND=">=dev-libs/libusb-0.1.8
	exif? ( >=media-libs/libexif-0.5.9 )
	hal? ( >=sys-apps/hal-0.5 )
	sys-devel/libtool"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	if ! echo "${USE}" | grep "cameras_" > /dev/null 2>&1; then
		einfo "libgphoto2 supports: all ${IUSE_CAMERAS}"
		einfo "All camera drivers will be built since you did not specify"
		einfo "via the CAMERAS variable what camera you use."
		ewarn "NOTICE: Upstream will not support you if you do not compile all camera drivers first"
	fi

	enewgroup plugdev || die "Error creating plugdev group"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-rpm.patch"

	# Fix for udev >= 098 rules generation
	epatch "${FILESDIR}"/${P}-udev-rules-fix2.diff
}

src_compile() {
	local cameras
	local cam
	for cam in ${IUSE_CAMERAS} ; do
		use "cameras_${cam}" && cameras="${cameras},${cam}"
	done
	[ -z "${cameras}" ] \
		&& cameras="all" \
		|| cameras="${cameras:1}"

	einfo "Enabled camera drivers: ${cameras}"
	[ "${cameras}" != "all" ] && \
		ewarn "Upstream will not support you if you do not compile all camera drivers first"

	CFLAGS="${CFLAGS} -DCANON_EXPERIMENTAL_20D"

	local myconf

	use exif \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	econf \
		--with-drivers=${cameras} \
		--with-doc-dir=/usr/share/doc/${PF} \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-hotplug-doc-dir=/usr/share/doc/${PF}/hotplug \
		$(use_enable nls) \
		--with-rpmbuild=/bin/true \
		--disable-docs \
		udevscriptdir=/lib/udev \
		GTKDOC=/bin/true \
		${myconf} || die "econf failed"
#		$(use_enable doc docs) \	TODO

	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	# fixup autoconf bug TODO
	if ! use doc && [ -d ${D}/usr/share/doc/${PF}/apidocs.html ]; then
		rm -fr "${D}/usr/share/doc/${PF}/apidocs.html"
	fi
	# end fixup

	# fixup udevscriptdir is not working TODO
	dodir /lib
	mv "${D}/usr/$(get_libdir)/udev" "${D}/lib" || die "Moving udev-helper files failed."
	# end fixup

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING

	HAL_FDI="/usr/share/hal/fdi/information/10freedesktop/10-camera-libgphoto2.fdi"
	UDEV_RULES="/etc/udev/rules.d/99-libgphoto2.rules"

	if [ -x ${D}/usr/$(get_libdir)/libgphoto2/print-camera-list ]; then
		# Let print-camera-list find libgphoto2.so
		export LD_LIBRARY_PATH="${D}/usr/$(get_libdir)"
		# Let libgphoto2 find its camera-modules
		export CAMLIBS="${D}/usr/$(get_libdir)/libgphoto2/${PV}"

		if use hal; then
			einfo "Generating HAL FDI files ..."
			mkdir -p ${D}/${HAL_FDI%/*}
			${D}/usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi >> ${D}/${HAL_FDI} \
				|| die "failed to create hal-fdi"
		fi

		einfo "Generating UDEV-rules ..."
		mkdir -p ${D}/${UDEV_RULES%/*}
		${D}/usr/$(get_libdir)/libgphoto2/print-camera-list \
			udev-rules-0.98	group plugdev mode 0660 >> ${D}/${UDEV_RULES} \
			|| die "failed to create udev-rules"
	else
		eerror "Unable to find print-camera-list"
		eerror "and therefore unable to generate hotplug usermap or HAL FDI files."
		eerror "You will have to manually generate it by running:"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list udev-rules-0.98 group plugdev mode 0660 > ${UDEV_RULES}"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi > ${HAL_FDI}"
	fi

}

pkg_postinst() {
	elog "Don't forget to add yourself to the plugdev group "
	elog "if you want to be able to access your camera."
}

