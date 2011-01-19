# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motion/motion-3.2.11.1.ebuild,v 1.6 2011/01/19 20:41:45 spatz Exp $

EAPI=2
inherit eutils

DESCRIPTION="Motion is a video motion detector with tracking-support for webcams."
HOMEPAGE="http://www.lavrsen.dk/twiki/bin/view/Motion/WebHome"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~x86"
IUSE="ffmpeg mysql postgres v4l"

RDEPEND="sys-libs/zlib
	virtual/jpeg
	ffmpeg? ( media-video/ffmpeg )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewuser motion -1 -1 -1 video
}

src_prepare() {
	sed -i \
		-e 's:jpeg_mem_dest:_jpeg_mem_dest:g' \
		picture.c || die
}

src_configure() {
	econf \
		$(use_with v4l) \
		$(use_with ffmpeg) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		--without-optimizecpu
}

src_install() {
	emake DESTDIR="${D}" install || die

	newinitd "${FILESDIR}"/motion.init-r1 motion
	newconfd "${FILESDIR}"/motion.confd motion

	# Create correct dir for motion.pid
	dodir /var/run/motion
	fowners motion:video /var/run/motion
	fperms 750 /var/run/motion
	keepdir /var/run/motion

	# Rename configuration file.
	mv "${D}"/etc/motion-dist.conf "${D}"/etc/motion.conf

	# Remove dummy documentation and install it using ebuild functions.
	rm -rf "${D}"/usr/share/doc/${P}
	dodoc CHANGELOG CODE_STANDARD CREDITS FAQ README README.FreeBSD *.conf
	dohtml *.html
}

pkg_postinst() {
	elog "You need to setup /etc/motion.conf before running"
	elog "motion for the first time. You can install motion"
	elog "detection as a service, use:"
	elog "rc-update add motion default"
}
