# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail/qmail-1.03-r6.ebuild,v 1.2 2002/07/11 06:30:47 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modern replacement for sendmail which uses maildirs"
HOMEPAGE="http://www.qmail.org/
          http://www.jedi.claranet.fr/qmail-tuning.html
          http://iain.cx/unix/qmail/mysql.php
          http://www.nrg4u.com/"

SRC_URI="http://cr.yp.to/software/qmail-1.03.tar.gz
         http://www.qmail.org/big-todo.103.patch
         http://www.qmail.org/big-concurrency.patch
         http://www.flounder.net/qmail/qmail-dns-patch"

DEPEND="virtual/glibc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=net-mail/checkpassword-0.90"

RDEPEND="virtual/glibc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=sys-apps/daemontools-0.76-r1
	>=net-mail/checkpassword-0.90"

PROVIDE="virtual/mta"

src_unpack() {

    cd ${WORKDIR}
    unpack qmail-1.03.tar.gz

    cd ${S}

    echo "Applying dns patch..."
    patch < ${DISTDIR}/qmail-dns-patch

    echo "Applying big-todo patch..."
    patch < ${DISTDIR}/big-todo.103.patch

    echo "Applying big-concurrency patch..."
    patch < ${DISTDIR}/big-concurrency.patch

    echo "Applying Ext2FS/ReiserFS patch..."
    patch < ${FILESDIR}/${PV}-${PR}/qmail-linksync.patch

    echo "gcc ${CFLAGS}" > conf-cc
    echo "gcc" > conf-ld
    echo "500" > conf-spawn

}

src_compile() {

    cd ${S}

    emake it man || die
}



src_install() {

    einfo "Setting up the required file hierarchy ..."
    cd ${S}
    diropts -m 755 -o root -g qmail
    dodir /var/qmail
	touch ${D}/var/qmail/.keep

    for i in bin boot control users
    do
        dodir /var/qmail/${i}
		touch ${D}/var/qmail/${i}/.keep
    done

    diropts -m 755 -o alias -g qmail
    dodir /var/qmail/alias
	touch ${D}/var/qmail/alias/.keep

    diropts -m 750 -o qmailq -g qmail
    dodir /var/qmail/queue
    dodir /var/qmail/queue/todo
	touch ${D}/var/qmail/queue/.keep
	touch ${D}/var/qmail/queue/todo/.keep

    diropts -m 700 -o qmailq -g qmail
    dodir /var/qmail/queue/pid
	touch ${D}/var/qmail/queue/pid/.keep

    diropts -m0700 -o qmails -g qmail
    dodir /var/qmail/queue/bounce
	touch ${D}/var/qmail/queue/bounce/.keep

    diropts -m 750 -o qmailq -g qmail
    dodir /var/qmail/queue/mess
	touch ${D}/var/qmail/queue/mess/.keep

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
    do
        dodir /var/qmail/queue/mess/${i}
		touch ${D}/var/qmail/queue/mess/${i}/.keep
        dodir /var/qmail/queue/todo/${i}
		touch ${D}/var/qmail/queue/todo/${i}/.keep
        dodir /var/qmail/queue/intd/${i}
		touch ${D}/var/qmail/queue/intd/${i}/.keep
    done

    diropts -m 700 -o qmails -g qmail
    for i in info local remote
    do
        dodir /var/qmail/queue/${i}
		touch ${D}/var/qmail/queue/${i}/.keep
    done

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
    do
        dodir /var/qmail/queue/info/${i}
		touch ${D}/var/qmail/queue/info/${i}/.keep
        dodir /var/qmail/queue/local/${i}
		touch ${D}/var/qmail/queue/local/${i}/.keep
        dodir /var/qmail/queue/remote/${i}
		touch ${D}/var/qmail/queue/remote/${i}/.keep
    done

    diropts -m 750 -o qmailq -g qmail 
    dodir /var/qmail/queue/lock
	touch ${D}/var/qmail/queue/lock/.keep

    dd if=/dev/zero of=${D}/var/qmail/queue/lock/tcpto bs=1024 count=1
    fperms 644 /var/qmail/queue/lock/tcpto
    fowners qmailr.qmail /var/qmail/queue/lock/tcpto

    touch ${D}/var/qmail/queue/lock/sendmutex
    fperms 600 /var/qmail/queue/lock/sendmutex
    fowners qmails.qmail /var/qmail/queue/lock/sendmutex
 
    mkfifo ${D}/var/qmail/queue/lock/trigger
    fperms 622 /var/qmail/queue/lock/trigger
    fowners qmails.qmail /var/qmail/queue/lock/trigger

    einfo "Installing the qmail software ..." 
    insopts -o root -g qmail -m 755
    insinto /var/qmail/boot
    doins home home+df proc proc+df binm1 binm1+df binm2 binm2+df binm3 binm3+df
 
    into /usr
    dodoc FAQ UPGRADE SENDMAIL INSTALL* TEST* REMOVE* PIC* SECURITY 
    dodoc SYSDEPS TARGETS THANKS THOUGHTS TODO VERSION
 
    insopts -o qmailq -g qmail -m 4711
    insinto /var/qmail/bin
    doins qmail-queue qmail-queue
        
    insopts -o root -g qmail -m 700
    insinto /var/qmail/bin
    doins qmail-lspawn qmail-start qmail-newu qmail-newmrh
        
    insopts -o root -g qmail -m 711
    insinto /var/qmail/bin
    doins qmail-getpw qmail-local qmail-remote qmail-rspawn \
        qmail-clean qmail-send splogger qmail-pw2u
 
    insopts -o root -g qmail -m 755
    insinto /var/qmail/bin
    doins qmail-inject predate datemail mailsubj qmail-showctl \
        qmail-qread qmail-qstat qmail-tcpto qmail-tcpok qmail-pop3d \
        qmail-popup qmail-qmqpc qmail-qmqpd qmail-qmtpd qmail-smtpd \
        sendmail tcp-env qreceipt qsmhook qbiff forward preline \
        condredirect bouncesaying except maildirmake maildir2mbox \
        maildirwatch qail elq pinq config-fast

    into /usr
    for i in *.1 *.5 *.8
    do
        doman $i
    done

    einfo "Creating sendmail replacement ..."
    diropts -m 755
    dodir /usr/sbin /usr/lib
    dosym /var/qmail/bin/sendmail /usr/sbin/sendmail
    dosym /var/qmail/bin/sendmail /usr/lib/sendmail

    einfo "Setting up the default aliases ..."
    diropts -m 700 -o alias -g qmail
    if [ ! -d ${ROOT}/var/qmail/alias/.maildir ] ; then
        dodir /var/qmail/alias/.maildir
        for i in cur new tmp
        do
            dodir /var/qmail/alias/.maildir/$i
        done
    fi

    for i in mailer-daemon postmaster root
    do
        touch ${D}/var/qmail/alias/.qmail-${i}
        fowners alias.qmail /var/qmail/alias/.qmail-${i}
    done
 
    einfo "Setting up maildirs by default in the account skeleton ..."
    diropts -m 755 -o root -g root
    insinto /etc/skel
    ${D}/var/qmail/bin/maildirmake ${D}/etc/skel/.maildir
    newins ${FILESDIR}/${PV}-${PR}/dot_qmail .qmail
    fperms 644 /etc/skel/.qmail
    insinto /root
    ${D}/var/qmail/bin/maildirmake ${D}/root/.maildir
    newins ${FILESDIR}/${PV}-${PR}/dot_qmail .qmail
    fperms 644 /root/.qmail

    einfo "Setting up daemontools ..."
    insopts -o root -g root -m 755
    diropts -m 755 -o root -g root
    dodir /var/qmail/supervise
    touch ${D}/var/qmail/supervise/.keep
    dodir /var/qmail/supervise/qmail-send
    touch ${D}/var/qmail/supervise/qmail-send/.keep
    dodir /var/qmail/supervise/qmail-send/log
    touch ${D}/var/qmail/supervise/qmail-send/.keep
    dodir /var/qmail/supervise/qmail-smtpd
    touch ${D}/var/qmail/supervise/qmail-smtpd/.keep
    dodir /var/qmail/supervise/qmail-smtpd/log
    touch ${D}/var/qmail/supervise/qmail-smtpd/.keep
    chmod +t ${D}/var/qmail/supervise/qmail-send
    chmod +t ${D}/var/qmail/supervise/qmail-smtpd
    diropts -m 755 -o qmaill
    dodir /var/log/qmail
    touch ${D}/var/log/qmail/.keep
    dodir /var/log/qmail/qmail-send
    touch ${D}/var/log/qmail/qmail-send/.keep
    dodir /var/log/qmail/qmail-smtpd
    touch ${D}/var/log/qmail/qmail-smtpd/.keep

    insinto /var/qmail/supervise/qmail-send
    newins ${FILESDIR}/${PV}-${PR}/run-qmailsend run
    insinto /var/qmail/supervise/qmail-send/log
    newins ${FILESDIR}/${PV}-${PR}/run-qmailsendlog run                            
    insinto /var/qmail/supervise/qmail-smtpd
    newins ${FILESDIR}/${PV}-${PR}/run-qmailsmtpd run                            
    insinto /var/qmail/supervise/qmail-smtpd/log
    newins ${FILESDIR}/${PV}-${PR}/run-qmailsmtpdlog run                            

    einfo "Installing the qmail control file ..."
    exeinto /var/qmail/bin
    doexe ${FILESDIR}/${PV}-${PR}/qmail-control

    einfo "Installing the qmail startup file ..."
    insinto /var/qmail
    doins ${FILESDIR}/${PV}-${PR}/rc

}

pkg_postinst() {

    echo -e "\e[32;01m Please do not forget to run, the following syntax :\033[0m"
    echo -e "\e[32;01m ebuild /var/db/pkg/${CATEGORY}/${PN}-${PV}-${PR}/${PN}-${PV}-${PR}.ebuild config \033[0m"
    echo -e "\e[32;01m This will setup qmail to run out-of-the-box on your system. \033[0m"
    echo -e ""
    echo -e "\e[32;01m To start qmail at boot you have to enable the /etc/init.d/svscan rc file \033[0m"
    echo -e "\e[32;01m and create the following links : \033[0m"
    echo -e "\e[32;01m ln -s /var/qmail/supervise/qmail-send /service/qmail-send \033[0m"
    echo -e "\e[32;01m ln -s /var/qmail/supervise/qmail-smtpd /service/qmail-smtpd \033[0m"

}

pkg_config() {

    export qhost=`hostname`			
    if [ ${ROOT} = "/" ] ; then
        if [ ! -f ${ROOT}/var/qmail/control/me ] ; then
            ${ROOT}/var/qmail/bin/config-fast $qhost 
        fi
    fi

    echo "Accepting relaying by default from all ips configured on this machine."
    LOCALIPS=`/sbin/ifconfig  | grep inet | cut -d " " -f 12 -s | cut -b 6-20`
    for ip in $LOCALIPS; do
        echo "$ip:allow,RELAYCLIENT=\"\"" >> /etc/tcp.smtp
    done
    echo ":allow" >> /etc/tcp.smtp

    tcprules /etc/tcp.smtp.cdb /etc/tcp.smtp.tmp < /etc/tcp.smtp

}
