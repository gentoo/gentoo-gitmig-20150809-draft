# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nut/nut-1.3.6.ebuild,v 1.1 2003/05/10 02:04:45 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Network-UPS Tools"
SRC_URI="http://www.exploits.org/nut/release/${PV%.*}/${P}.tar.gz"
HOMEPAGE="http://www.exploits.org/nut/"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND=">=sys-apps/baselayout-1.8.2"


if [ "`use apache2`" ]; then
	APACHEBIN="apache2"
else
	APACHEBIN="apache"
fi

APACHE="`which ${APACHEBIN}`"
if [ -z "${APACHE}" -a -x /usr/sbin/${APACHEBIN} ]; then
  APACHE=/usr/sbin/${APACHEBIN}
fi

if [ -n "${APACHE}" ]; then
  DEPEND="${DEPEND} =sys-libs/zlib-1* =media-libs/libgd-1* =media-libs/libpng-1.2*"
  RDEPEND="${RDEPEND} net-www/apache"
fi
RDEPEND="${RDEPEND} ${DEPEND}"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	cp configure.in configure.in.orig
	sed -e "s:GD_LIBS.*=.*-L/usr/X11R6/lib \(.*\) -lXpm -lX11:GD_LIBS=\"\1:" \
		configure.in.orig >configure.in
	WANT_AUTOCONF_2_5=1 autoconf || die
}

src_compile() {
	local myconf
	[ -n "${APACHE}" ] && myconf="--with-cgi --with-cgipath=/home/httpd/cgi-bin" || myconf="--without-cgi"

	#default is to build all drivers; but the following is common:
	#--with-drivers=apcsmart,hidups
	./configure \
		--prefix=/usr \
		--with-user=nut \
		--with-group=nut \
		--with-port=3493 \
		--with-drvpath=/sbin \
		--sysconfdir=/etc/nut \
		--mandir=/usr/share/man \
		--with-pidpath=/var/run \
		--with-logfacility=LOG_DAEMON \
		--with-statepath=/var/state/nut \
		--with-altpidpath=/var/state/nut \
		--with-linux-hiddev \
		--host=${CHOST} ${myconf} || die

	cp ${S}/drivers/Makefile ${S}/drivers/Makefile.orig
	sed -e "s:= bestups:= hidups bestups:" ${S}/drivers/Makefile.orig \
		> ${S}/drivers/Makefile
	cp ${S}/man/Makefile ${S}/man/Makefile.orig
	sed -e "s:= powercom.8:= hidups.8 powercom.8:" \
		${S}/man/Makefile.orig > ${S}/man/Makefile

	emake || die

	if [ -n "${APACHE}" ]
	then
		emake cgi || die
	fi
}

src_install() {
	# Makefile: user/group nut might not exist until after
	# pkg_preinst() runs; so use root for now, and fix it
	# up in pkg_postinst().
	make DESTDIR=${D} RUNUID=root RUNGID=root install || die

	if [ -n "${APACHE}" ]
	then
		make DESTDIR=${D} install-cgi || die
	fi
	# see above note...
	rm -rf ${D}/var/state/nut

	dodoc CHANGES COPYING CREDITS INSTALL NEWS README \
		UPGRADING docs/{FAQ,*.txt,driver.list}
	docinto cables ; dodoc docs/cables/*
	docinto drivers ; dodoc docs/drivers/*

	# clean up /etc/nut/*.sample files
	cd ${D}/etc/nut
	for i in *.sample
	do
		mv $i ${i/.sample/}
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/upsd-init upsd
	newexe ${FILESDIR}/upsmon-init upsmon
}

pkg_preinst() {
	if ! groupmod nut ; then
		groupadd -g 84 nut || die "problem adding group nut"
	fi

	# usermod returns 2 on user-exists-but-no-flags-given
	usermod nut &>/dev/null
	if [ $? != 2 ] ; then
		useradd -u 84 -g nut -s /bin/false -c "nut" \
			-d /var/state/nut nut || die "problem adding user nut"
	fi
}

pkg_postinst() {
	install -m0700 -o nut -g nut -d ${ROOT}/var/state/nut
	chown root.nut ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf}
	chmod 640 ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf}
	ewarn "Dont forget to merge any changes in /etc/init.d/._cfgXXXX_halt.sh"
}
