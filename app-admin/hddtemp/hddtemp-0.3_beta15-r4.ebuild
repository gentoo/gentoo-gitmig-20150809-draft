# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta15-r4.ebuild,v 1.2 2010/07/05 13:17:20 spock Exp $

inherit eutils autotools

MY_P=${P/_beta/-beta}
DBV=20080531

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"
SRC_URI="http://www.guzu.net/files/${MY_P}.tar.bz2 mirror://gentoo/hddtemp-${DBV}.db.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="network-cron nls"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-satacmds.patch
	epatch "${FILESDIR}"/${P}-byteswap.patch
	epatch "${FILESDIR}"/${P}-execinfo.patch
	epatch "${FILESDIR}"/${P}-nls.patch
	epatch "${FILESDIR}"/${P}-iconv.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	local myconf

	myconf="--with-db-path=/usr/share/hddtemp/hddtemp.db"
	# disabling nls breaks compiling
	use nls || myconf="--disable-nls ${myconf}"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO ChangeLog

	insinto /usr/share/hddtemp
	newins "${WORKDIR}/hddtemp-${DBV}.db" hddtemp.db
	doins "${FILESDIR}"/hddgentoo.db

	update_db "${D}/usr/share/hddtemp/hddgentoo.db" "${D}/usr/share/hddtemp/hddtemp.db"
	newconfd "${FILESDIR}"/hddtemp-conf.d hddtemp
	newinitd "${FILESDIR}"/hddtemp-init hddtemp

	dosbin "${FILESDIR}"/update-hddtemp.db

	if use network-cron ; then
		exeinto /etc/cron.monthly
		echo -e "#!/bin/sh\n/usr/sbin/update-hddtemp.db" > "${T}"/hddtemp.cron
		newexe "${T}"/hddtemp.cron update-hddtemp.db \
			|| die "Failed to install update cronjob"
	fi
}

pkg_postinst() {
	einfo "In order to update your hddtemp database, run:"
	einfo "  update-hddtemp.db"
	einfo "If your hard drive is not recognized by hddtemp, please consider"
	einfo "submitting your HDD info for inclusion into the Gentoo hddtemp"
	einfo "database by filing a bug at https://bugs.gentoo.org/"
}

update_db() {
	local src=$1
	local dst=$2

	while read line ; do
		if [[ -z $(echo "${line}" | sed -re 's/(^#.*|^\w*$)//') ]]; then
			echo "${line}" >> "${dst}"
		fi

		id=$(echo "${line}" | grep -o '"[^"]*"')

		grep "${id}" "${dst}" 2>&1 >/dev/null || echo "${line}" >> "${dst}"
	done < "${src}"
}
