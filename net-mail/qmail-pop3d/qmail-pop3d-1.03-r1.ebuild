# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-pop3d/qmail-pop3d-1.03-r1.ebuild,v 1.3 2002/07/17 05:07:51 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Pop3 configuration for qmail which used the maildirs of the users"
HOMEPAGE="http://www.qmail.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=net-mail/qmail-1.03-r6"

src_unpack() {

    einfo "Nothing to unpack ..."

}

src_compile() {

    einfo "Nothing to compile ..."

}


src_install() {

    einfo "Setting up the pop3d service ..."
    insopts -o root -g root -m 755
    diropts -m 755 -o root -g root
    dodir /service
    dodir /var/qmail/supervise/qmail-pop3d
    dodir /var/qmail/supervise/qmail-pop3d/log
    chmod +t ${D}/var/qmail/supervise/qmail-pop3d
    diropts -m 755 -o qmaill
    dodir /var/log/qmail/qmail-pop3d

    insinto /var/qmail/supervise/qmail-pop3d
    newins ${FILESDIR}/run-qmailpop3d run
    insinto /var/qmail/supervise/qmail-pop3d/log
    newins ${FILESDIR}/run-qmailpop3dlog run                            

}

pkg_postinst() {

    echo -e "\e[32;01m To start qmail-pop3d at boot you have to start /etc/init.d/svscan at boot \033[0m"
    echo -e "\e[32;01m and create the following link : \033[0m"
    echo -e "\e[32;01m ln -s /var/qmail/supervise/qmail-pop3d /service/qmail-pop3d \033[0m"

}
