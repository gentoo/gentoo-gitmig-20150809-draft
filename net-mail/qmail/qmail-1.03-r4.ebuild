# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
$HEADER$

S=${WORKDIR}/qmail-1.03
DESCRIPTION="A modern replacement for sendmail which uses maildirs"

QMAIL_SRC="http://cr.yp.to/software/qmail-1.03.tar.gz
           http://www.qmail.org/big-todo.103.patch
           http://www.qmail.org/big-concurrency.patch
           http://www.jedi.claranet.fr/qmail-link-sync.patch"
MYSQL_SRC="http://iain.cx/unix/qmail/qmail-mysql.patch"
LDAP_SRC="http://www.nrg4u.com/qmail/qmail-ldap-1.03-20001201.patch.gz"

QMAIL_DEP="virtual/glibc
	   >=net-mail/checkpassword-0.90"

MYSQL_DEP=">=dev-db/mysql-3.23.28"
LDAP_DEP=">=net-nds/openldap-1.2.11"

HOMEPAGE="http://www.qmail.org/
          http://www.jedi.claranet.fr/qmail-tuning.html
          http://iain.cx/unix/qmail/mysql.php
          http://www.nrg4u.com/"

# oversize dns patch (unnecessary?)
#         http://www.ckdhr.com/ckd/qmail-1.03.patch

if [ "${P}" = "qmail-mysql-1.03" ]; then
    SRC_URI="${QMAIL_SRC} ${MYSQL_SRC}"
    DEPEND="${QMAIL_DEP} ${MYSQL_DEP}"
elif [ "${P}" = "qmail-ldap-1.03" ]; then
    SRC_URI="${QMAIL_SRC} ${LDAP_SRC}"
    DEPEND="${QMAIL_DEP} ${LDAP_DEP}"
else
    SRC_URI="${QMAIL_SRC}"
    DEPEND="${QMAIL_DEP}"
fi

PROVIDE="virtual/mta"
RDEPEND="$DEPEND"
DEPEND="$DEPEND sys-apps/groff"



src_unpack() {
    cd ${WORKDIR}
    unpack qmail-1.03.tar.gz

    cd ${S}
    echo Applying big-todo patch...
    patch < ${DISTDIR}/big-todo.103.patch

    echo Applying big-concurrency patch...
    patch < ${DISTDIR}/big-concurrency.patch

    echo Applying Ext2FS/ReiserFS patch...
    patch < ${DISTDIR}/qmail-link-sync.patch

    if [ "${P}" = "qmail-mysql-1.03" ]; then
        cd ${S}
        echo Applying MySQL patch...
        patch < ${DISTDIR}/qmail-mysql.patch
    fi

    echo "gcc ${CFLAGS}" > conf-cc
    echo "gcc" > conf-ld
    echo "500" > conf-spawn
}


src_compile() {
    cd ${S}

    if [ "${P}" = "qmail-mysql-1.03" ]; then
        cp Makefile Makefile.orig
        sed -e "s:MYSQL_LIBS=.*:MYSQL_LIBS=/usr/lib/mysql/libmysqlclient.a -lm:" \
            -e "s:MYSQL_INCLUDE=.*:MYSQL_INCLUDE=-I/usr/include/mysql:" Makefile.orig > Makefile
    fi

    try make it man
}



src_install() {                 
    cd ${S}
    diropts -m 755 -o root -g qmail
    dodir /var/qmail

    for i in bin boot control users
    do
        dodir /var/qmail/$i
    done

    diropts -m 755 -o alias -g qmail
    dodir /var/qmail/alias

    diropts -m 750 -o qmailq -g qmail
    dodir /var/qmail/queue
    dodir /var/qmail/queue/todo

    diropts -m 700 -o qmailq -g qmail
    dodir /var/qmail/queue/pid

    diropts -m0700 -o qmails -g qmail
    dodir /var/qmail/queue/bounce

    diropts -m 750 -o qmailq -g qmail
    dodir /var/qmail/queue/mess

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
    do
        dodir /var/qmail/queue/mess/$i
        dodir /var/qmail/queue/todo/$i
        dodir /var/qmail/queue/intd/$i
    done

    diropts -m 700 -o qmails -g qmail
    for i in info local remote
    do
        dodir /var/qmail/queue/$i
    done

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
    do
        dodir /var/qmail/queue/info/$i
        dodir /var/qmail/queue/local/$i
        dodir /var/qmail/queue/remote/$i
    done

    diropts -m 750 -o qmailq -g qmail 
    dodir /var/qmail/queue/lock

    dd if=/dev/zero of=${D}/var/qmail/queue/lock/tcpto bs=1024 count=1
    fperms 644 /var/qmail/queue/lock/tcpto
    fowners qmailr.qmail /var/qmail/queue/lock/tcpto

    touch ${D}/var/qmail/queue/lock/sendmutex
    fperms 600 /var/qmail/queue/lock/sendmutex
    fowners qmails.qmail /var/qmail/queue/lock/sendmutex
 
    mkfifo ${D}/var/qmail/queue/lock/trigger
    fperms 622 /var/qmail/queue/lock/trigger
    fowners qmails.qmail /var/qmail/queue/lock/trigger
 
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

    diropts -m 755
    dodir /usr/sbin /usr/lib
    dosym /var/qmail/bin/sendmail /usr/sbin/sendmail
    dosym /var/qmail/bin/sendmail /usr/lib/sendmail

    into /usr
    for i in *.1 *.5 *.8
    do
        doman $i
    done

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
 
    insinto /etc/rc.d/init.d
    insopts -m755
    doins ${O}/files/qmail
    dodir ${D}/var/qmail/bin/maildirmake /etc/skel/.maildir
    dodir ${D}/var/qmail/bin/maildirmake /root/.maildir
    mkdir ${D}/usr/local
    mkdir ${D}/usr/local/bin
    cp ${FILESDIR}/tcp.smtp ${D}/etc/tcp.smtp
    cp ${FILESDIR}/tcp.smtp.cdb ${D}/etc/tcp.smtp.cdb
    cp ${FILESDIR}/tcprulesedit.sh ${D}/usr/bin/tcprulesedit.sh	
    echo -e "\033[1;42m\033[1;33m Please do not forget to run, the following syntax : \033[0m"
    echo -e "\033[1;42m\033[1;33m ebuild qmail-1.03-r4.ebuild config \033[0m"
    echo -e "\033[1;42m\033[1;33m This will add the necessary post install config to your system. \033[0m"
}


 pkg_config() {
     ${ROOT}/usr/sbin/rc-update add qmail

#     export QmailHost="localhost"
      export qhost=`hostname`			
     if [ ${ROOT} = "/" ] ; then
 
       if [ ! -f ${ROOT}/var/qmail/control/me ] ; then
           ${ROOT}/var/qmail/bin/config-fast $qhost 
       fi
 
     fi
/etc/rc.d/init.d/qmail start
echo "Modifications Applied and Qmail Started."
 }
