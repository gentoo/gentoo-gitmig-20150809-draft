# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/glftpd/glftpd-2.00.ebuild,v 1.3 2005/03/24 01:41:16 vapier Exp $

inherit eutils

MY_P=${P/-/-LNX_}
DESCRIPTION="a HIGHLY configurable ftp server"
HOMEPAGE="http://www.glftpd.com/"
SRC_URI="http://www.glftpd.com/files/${MY_P}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}
	sys-apps/xinetd"

S=${WORKDIR}/${MY_P}

# custom options
export CUSTOMGLROOT=${CUSTOMGLROOT:-/opt/glftpd}
export GLROOT=${GLROOT:-${D}${CUSTOMGLROOT}}

pkg_setup() {
	[[ -d /proc/sysvipc ]] || die "You need System V IPC support in your kernel"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp installgl.sh{,.orig}
	epatch "${FILESDIR}"/${P}-install.patch
	epatch "${FILESDIR}"/${P}-gcc.patch
	epatch "${FILESDIR}"/${P}-script-path-checks.patch
}

yesno() { if $@ ; then echo y ; else echo n ; fi ; }

src_install() {
	dodir /etc/xinetd.d

	# custom options
	export USETCPD=$(yesno useq tcpd)
	export JAIL=y
	export MAKETLS=$(yesno [[ ! -e ${ROOT}/etc/glftpd-dsa.pem ]])
	export WHICHNETD=x
	"${S}"/installgl.sh || die "installgl.sh failed"

	# fix the glftpd.conf file
	sed -i \
		-e "s:${GLROOT}:${CUSTOMGLROOT}/:" \
		${GLROOT}/glftpd.conf

	mv ${GLROOT}/glftpd.conf ${D}/etc/
	ln -s /etc/glftpd.conf ${GLROOT}/glftpd.conf
	if [[ -e ${ROOT}/etc/glftpd-dsa.pem ]] ; then
		cp "${ROOT}"/etc/glftpd-dsa.pem "${D}"/etc/
	else
		cp ftpd-dsa.pem "${D}"/etc/glftpd-dsa.pem
	fi
	ln -s /etc/glftpd-dsa.pem ${GLROOT}/etc/glftpd-dsa.pem
	fperms o-r /etc/glftpd-dsa.pem

	# xinetd.d entry (use our custom one :])
	insinto /etc/xinetd.d
	newins ${FILESDIR}/glftpd.xinetd.d glftpd
	dosed "s:GLROOT:${CUSTOMGLROOT}:g" /etc/xinetd.d/glftpd

	# env entry to protect our ftp passwd/group files
	newenvd ${FILESDIR}/glftpd.env.d 99glftpd
	dosed "s:GLROOT:${CUSTOMGLROOT}:g" /etc/env.d/99glftpd

	# chmod the glftpd dir so that user files will work
	chmod 711 ${GLROOT}
}

pkg_postinst() {
	echo
	einfo "Read the documentation in /opt/glftpd/docs/"
	einfo "After you setup your conf file, edit the xinetd"
	einfo "entry in /etc/xinetd.d/glftpd to enable, then"
	einfo "start xinetd: /etc/init.d/xinetd start"
	echo
	einfo "To add glftpd to your services file and to"
	einfo "create a cronjob for auto generating statistics,"
	einfo "just run this command after you install:"
	echo
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
}

pkg_config() {
	einfo "Updating /etc/services"
	{ grep -v ^glftpd /etc/services;
	echo "glftpd   21/tcp"
	} > /etc/services.new
	mv -f /etc/services.new /etc/services

	einfo "Updating crontab"
	{ crontab -l | grep -v "bin/reset"
	echo "0  0 * * *      ${CUSTOMGLROOT}/bin/reset -r ${CUSTOMGLROOT}/glftpd.conf"
	} | crontab - > /dev/null
}
