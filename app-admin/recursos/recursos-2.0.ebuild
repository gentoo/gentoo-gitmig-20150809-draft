# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/recursos/recursos-2.0.ebuild,v 1.2 2006/08/23 16:14:58 mr_bones_ Exp $

DESCRIPTION="Script to create html and text report about your system."
HOMEPAGE="http://www.josealberto.org"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="media-gfx/imagemagick
app-shells/bash
net-analyzer/rrdtool"

S=${WORKDIR}/r2

src_install() {
	WWWDIR="/var/www/localhost/htdocs/R2"

	insinto /etc
	doins recursos2.conf

	dobin R2createrrd.sh R2generarrd.sh R2updaterrd.sh Recursos2.sh

	dodir ${WWWDIR}
	insinto ${WWWDIR}
	doins R2/*.html

	dodir ${WWWDIR}/common
	insinto ${WWWDIR}/common
	doins R2/common/*

	dodir ${WWWDIR}/rrd/mini
}

pkg_postinst() {
	einfo "Fist you must configure /etc/recursos2.conf"
	einfo "Then follow these steps:"
	echo
	einfo "1. Run R2createrrd.sh"
	echo
	einfo "2. Add crontab jobs (this is an example):"
	einfo "*/2 * * * *     root    /usr/bin/R2updaterrd.sh"
	einfo "*/5 * * * *     root    /usr/bin/R2generarrd.sh"
	einfo "*/10 * * * *    root    /usr/bin/Recursos2.sh \ "
	einfo "    title general system disks net \ "
	einfo "    > /var/www/localhost/htdocs/recursos.html"
	echo
	einfo "You can use Recursos2.sh to extract info about your system"
	einfo "in html or plain text and mail the file or whatever."
	echo
}
