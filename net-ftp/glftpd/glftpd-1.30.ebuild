# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/glftpd/glftpd-1.30.ebuild,v 1.1 2003/04/29 15:26:29 vapier Exp $

MY_P=${P/-/-LNX_}
DESCRIPTION="a HIGHLY configurable ftp server"
HOMEPAGE="http://www.glftpd.com/"
SRC_URI="http://www.glftpd.com/files/${MY_P}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="sys-apps/xinetd"

S=${WORKDIR}/${MY_P}
GLROOT="${D}/opt/glftpd/"
[ -z "${GLFTPD_PORT}" ]	&&	GLFTPD_PORT=21

pkg_setup() {
	[ -d /proc/sysvipc/ ] || die "You need System V IPC support in your kernel"
}

src_compile() {
	[ "( use tcpd )" ]	&&	USETCPD=y	||	USETCPD=n
	[ -z "${JAIL}" ]	&&	JAIL=y		||	JAIL=n
	WHICHNETD=x

	cp ${S}/installgl.sh ${S}/installgl.sh.old
	sed -e "s:read usetcpd:usetcpd=${USETCPD}:" \
	 -e "s:read jaildir:jaildir=${GLROOT}:" \
	 -e "s:read jail:jail=y:" \
	 -e "s:read reply:echo OMG; exit 1:" \
	 -e "s:read useprivgroup:useprivgroup=n:" \
	 -e "s:read glroot:break:" \
	 -e "s:read port:port=${GLFTPD_PORT}:" \
	 -e "s:read whichnetd:whichnetd=x:" \
	 -e "s:killall -USR2 xinetd:0:" \
	 -e "s:/etc/xinetd.d/glftpd:${D}/etc/xinetd.d/glftpd:" \
	 -e "s:> /etc/services.new:>/dev/null:" \
	 -e "s:mv -f /etc/services.new:dumbvar=:" \
	 -e "s:| crontab -:>/dev/null:" \
		${S}/installgl.sh.old > ${S}/installgl.sh
}

src_install() {
	dodir /etc/xinetd.d

	${S}/installgl.sh

	# fix the glftpd.conf file
	cp ${GLROOT}/glftpd.conf ${GLROOT}/glftpd.conf.old
	sed -e "s:${GLROOT}:/opt/glftpd/:" \
		${GLROOT}/glftpd.conf.old > ${GLROOT}/glftpd.conf
	rm ${GLROOT}/glftpd.conf.old

	mv ${GLROOT}/glftpd.conf ${D}/etc/
	ln -s /etc/glftpd.conf ${GLROOT}/glftpd.conf

	# xinetd.d entry (use our custom one :])
	insinto /etc/xinetd.d
	newins ${FILESDIR}/glftpd.xinetd.d glftpd

	# env entry to protect our ftp passwd/group files
	insinto /etc/env.d
	newins ${FILESDIR}/glftpd.env.d 99glftpd

	# chmod the glftpd dir so that user files will work
	chmod 711 ${D}/opt/glftpd
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
	einfo "ebuild /var/db/pkg/${CATEGORY}/${P}/${P}.ebuild config"
	echo
}

pkg_config() {
	einfo "Updating /etc/services"
	{ grep -v ^glftpd /etc/services;
	echo "glftpd   ${GLFTPD_PORT}/tcp"
	} > /etc/services.new
	mv -f /etc/services.new /etc/services

	einfo "Updating crontab"
	{ crontab -l | grep -v "bin/reset"
	echo "0  0 * * *      $jaildir$glroot/bin/reset $confpath"
	} | crontab - > /dev/null
}
