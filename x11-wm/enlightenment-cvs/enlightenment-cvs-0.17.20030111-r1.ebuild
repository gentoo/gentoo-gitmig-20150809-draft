# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment-cvs/enlightenment-cvs-0.17.20030111-r1.ebuild,v 1.1 2003/01/12 07:37:22 vapier Exp $

ECVS_SERVER="cvs.enlightenment.sourceforge.net:/cvsroot/enlightenment"
ECVS_MODULE="e17"
ECVS_CVS_OPTIONS="-dP"
ECVS_BRANCH="SPLIT"

inherit cvs

DESCRIPTION="Enlightenment Window Manager"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="pic X mmx truetype opengl directfb fbcon png jpeg"

RDEPEND="sys-libs/pam"
DEPEND="app-admin/fam-oss
	dev-libs/libxml2
	dev-libs/libpcre
	dev-lang/ferite
	media-libs/imlib2
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	dev-util/pkgconfig"

S=${WORKDIR}/${ECVS_MODULE}
E_PREFIX=/usr/e17

pkg_setup() {
	einfo "If you experience a problem with the ebuild, then"
	einfo "e-mail me at vapier@gentoo.org and/or file a bug"
	einfo "assigned to me."
	echo
	ewarn "this ebuild moves ${E_PREFIX} to ${E_PREFIX}.old in the case"
	ewarn "that you already have a version installed ..."
	ewarn "this is needed when newer cvs releases depend on newer versions"
	ewarn "of libraries and older versions just cause breakage"

	[ -e ${E_PREFIX}.old -a ! -h ${E_PREFIX} ] && die "do something about ${E_PREFIX}.old"
	dodir ${E_PREFIX}
	[ -e ${E_PREFIX} ] && mv ${E_PREFIX} ${E_PREFIX}.old
	ln -sf ${D}/${E_PREFIX} ${E_PREFIX}
}

src_unpack() {
	unpack ${A}
#	cp -rf ${DISTDIR}/cvs-src/e17 ${WORKDIR}
}

src_install() {
	# anytime you see --> echo "all:"$'\n\t'"echo done">test/Makefile
	# it means i disabled the test building ... i could do a sed on that
	# Makefile to make it work, but its just a test app ... who cares ...
	# for some reason, `make LDFLAGS="-L -L -L"` doesnt work, so its punted

	export baseconf="--prefix=${E_PREFIX} --with-gnu-ld --enable-shared `use_with pic`"
	export addconf=""

	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize

	# HEAD uses autogen.sh but SPLIT doesnt always ...
	eautogen="
		#!/bin/bash
		if [ -x ./autogen.sh ] ; then
			./autogen.sh \$@
		else
			./configure \$@
		fi"
	echo "${eautogen}" > ${T}/eautogen
	chmod a+x ${T}/eautogen

	# find our haxed script first, the -config scripts 2nd, everything else last
	PATH="${T}:${E_PREFIX}/bin:${PATH}"
	CFLAGS="${CFLAGS} -I${E_PREFIX}/include -I${E_PREFIX}/include/ewd"
	export WANT_AUTOCONF_2_5=1
	export WANT_AUTOMAKE_1_6=1

	############
	### libs ###
	############

	### imlib2 ###
	# mmx support in imlib2 makes other things complain it would seem ...
	# *shrug*, worked for me ;D
	einfo "making libs/imlib2"
	cd ${S}/libs/imlib2
	addconf="--disable-mmx"
	use X		&& addconf="${addconf} --with-x"
#	use mmx		&& addconf="${addconf} --enable-mmx"
	use truetype	&& addconf="${addconf} --with-ttf=/usr"
	env USER=BS eautogen ${baseconf} ${addconf} || die "could not autogen imlib2"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make imlib2"
	make install DESTDIR=${D} || die "could not install imlib2"

	### edb ###
	einfo "making libs/edb"
	cd ${S}/libs/edb
	addconf="--enable-cxx"
	eautogen ${baseconf} ${addconf} || die "could not autogen edb"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make edb"
	make install DESTDIR=${D} || die "could not install edb"

	### eet ###
	einfo "making libs/eet"
	cd ${S}/libs/eet
	cp configure.ac{,.old}
	sed -e "s:src/bin/Makefile:src/bin/Makefile eet-config],\n[\nchmod +x eet-config\n:" \
		configure.ac.old > configure.ac
	echo 'bin_SCRIPTS = eet-config' >> Makefile.am
	eautogen ${baseconf} || die "could not autogen eet"
	make || die "could not make eet"
	make install DESTDIR=${D} || die "could not install eet"

	### imlib2_loaders ###
	einfo "making libs/imlib2_loaders"
	cd ${S}/libs/imlib2_loaders
	use X		&& addconf="${addconf} --with-x"
	env -u CFLAGS eautogen ${baseconf} ${addconf} || die "could not autogen imlib2_loaders"
	make CFLAGS="${CFLAGS}" || die "could not make imlib2_loaders"
	make install DESTDIR=${D} || die "could not install imlib_loaders"

	### evas ###
	einfo "making libs/evas"
	cd ${S}/libs/evas
	addconf=" \
		--enable-image-loader-eet \
		--enable-image-loader-edb \
		--enable-fmemopen \
		--enable-cpu-c \
		--enable-scale-smooth \
		--enable-scale-sample \
		--enable-convert-8-rgb-332 \
		--enable-convert-8-rgb-666 \
		--enable-convert-8-rgb-232 \
		--enable-convert-8-rgb-222 \
		--enable-convert-8-rgb-221 \
		--enable-convert-8-rgb-121 \
		--enable-convert-8-rgb-111 \
		--enable-convert-16-rgb-565 \
		--enable-convert-16-rgb-555 \
		--enable-convert-16-rgb-rot-0 \
		--enable-convert-32-rgb-8888 \
		--enable-convert-32-rgbx-8888 \
		--enable-convert-32-bgr-8888 \
		--enable-convert-32-bgrx-8888 \
		--enable-convert-32-rgb-rot-0"
	use X		&& addconf="${addconf} --enable-software-x11"
	use opengl	&& addconf="${addconf} --enable-gl-x11"
#	use directfb	&& addconf="${addconf} --enable-directfb"
	use fbcon	&& addconf="${addconf} --enable-fb"
	use png		&& addconf="${addconf} --enable-image-loader-png"
	use jpeg	&& addconf="${addconf} --enable-image-loader-jpeg"
#	use mmx		&& addconf="${addconf} --enable-cpu-mmx"
	eautogen ${baseconf} ${addconf} || die "could not autogen evas"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make evas"
	make install DESTDIR=${D} || die "could not install evas"

	### ewd ###
	einfo "making libs/ewd"
	cd ${S}/libs/ewd
	eautogen ${baseconf} || die "could not autogen ewd"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make ewd"
	make install DESTDIR=${D} || die "could not install ewd"

	### ebits ###
	einfo "making libs/ebits"
	cd ${S}/libs/ebits
	eautogen ${baseconf} || die "could not autogen ebits"
	make || die "could not make ebits"
	make install DESTDIR=${D} || die "could not install ebits"

	### ecore ###
	einfo "making libs/ecore"
	cd ${S}/libs/ecore
	addconf=
	use X		&& addconf="${addconf} --with-x"
	eautogen ${baseconf} ${addconf} || die "could not autogen ecore"
	make || die "could not make ecore"
	make install DESTDIR=${D} || die "could not install ecore"

	### estyle ###
	einfo "making libs/estyle"
	cd ${S}/libs/estyle
	eautogen ${baseconf} || die "could not autogen estyle"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make estyle"
	make install DESTDIR=${D} || die "could not install estyle"

	### etox ###
	einfo "making libs/etox"
	cd ${S}/libs/etox
	eautogen ${baseconf} || die "could not autogen etox"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make etox"
	make install DESTDIR=${D} || die "could not install etox"

	### ebg ###
	einfo "making libs/ebg"
	cd ${S}/libs/ebg
	eautogen ${baseconf} || die "could not autogen ebg"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make ebg"
	make install DESTDIR=${D} || die "could not install ebg"

	### ewl ###
	einfo "making libs/ewl"
	cd ${S}/libs/ewl
	env USER=BS eautogen ${baseconf} || die "could not autogen ewl"
	cp ${FILESDIR}/dummy.Makefile test/Makefile
	make || die "could not make ewl"
	make install DESTDIR=${D} || die "could not install ewl"

	### eprog ###
	einfo "making libs/eprog"
	cd ${S}/libs/eprog
	cp configure{,.old}
	sed -e "s:^PREFIX.*:PREFIX=${E_PREFIX}:" \
		configure.old > configure
	./configure || die "could not make eprog"
	echo "PREFIX=${D}${E_PREFIX}" > .config
	./configure install || die "could not install eprog"

	############
	### apps ###
	############

	### entice ###
	einfo "making apps/entice"
	cd ${S}/apps/entice
	addconf="--disable-nls --with-included-gettext"
	cp Makefile.am Makefile.am.old
	sed -e "s:intl po::" Makefile.am.old > Makefile.am
	cp configure.in configure.in.old
	sed -e "s:intl/Makefile po/Makefile.in::" configure.in.old > configure.in
	eautogen ${baseconf} ${addconf} || die "could not autogen entice"
	make || die "could not make entice"
	make install DESTDIR=${D} || die "could not install entice"

	### esmall ###
	einfo "making apps/esmall"
	cd ${S}/apps/esmall
	eautogen ${baseconf} || die "could not autogen esmall"
	if [ "${ARCH}" == "ppc" ] ; then
		for f in `grep sys/io src/* -l` ; do
			cp ${f}{,.old}
			sed -e 's:sys/io:asm/io:' ${f}.old > ${f}
		done
	fi
	make || die "could not make esmall"
	make install DESTDIR=${D} || die "could not install esmall"

	### ewidgetd ###
# this guy does not build ... doesnt look done anyways
#	einfo "making apps/ewidgetd"
#	cd ${S}/apps/ewidgetd
#	eautogen ${baseconf} || die "could not autogen ewidgetd"
#	./configure ${baseconf}
#	cp libewidget/libewidget.c{,.old}
#	sed -e "s:stdio:stdlib:" libewidget/libewidget.c > libewidget/libewidget.c.old
#	make CFLAGS="${CFLAGS} -I${S}/apps/ewidgetd/libeipc" || die "could not make ewidgetd"
#	make install DESTDIR=${D} || die "could not install ewidgetd"

	### essence ###
# this guy does not build ... doesnt look done anyways
#	einfo "making apps/essence"
#	cd ${S}/apps/essence
#	cp configure.in{,.old}
#	sed -e "s:intl/Makefile::" configure.in.old > configure.in
#	eautogen ${baseconf} || die "could not autogen essence"
#	make || die "could not make essence"
#	make install DESTDIR=${D} || die "could not install essence"

	### elicit ###
	einfo "making apps/elicit"
	cd ${S}/apps/elicit
	cp configure{,.old}
	sed -e "s:^PREFIX.*:PREFIX=${E_PREFIX}:" \
		configure.old > configure
	./configure || die "could not make elicit"
	echo "PREFIX=${D}${E_PREFIX}" > .config
	./configure install || die "could not install elicit"

	### efileinfo ###
# this guy does not build ... needs to be updated to new evas
#	einfo "making apps/efileinfo"
#	cd ${S}/apps/efileinfo
#	cp Makefile.am{,.old}
#	sed -e "s:intl po::" Makefile.am.old > Makefile.am
#	cp configure.in{,.old}
#	sed -e "s:po/Makefile.in::" \
#	 -e "s:intl/Makefile::" \
#	 -e "s:po/Makefile::" \
#		configure.in.old > configure.in
#	eautogen ${baseconf} || die "could not autogen efileinfo"
#	make || die "could not make efileinfo"
#	make install DESTDIR=${D} || die "could not install efileinfo"

	### imlib2_tools ###
	einfo "making apps/imlib2_tools"
	cd ${S}/apps/imlib2_tools
	env USER=BS eautogen ${baseconf} || die "could not autogen imlib2_tools"
	make || die "could not make imlib2_tools"
	make install DESTDIR=${D} || die "could not install imlib2_tools"

	### etcher ###
	einfo "making apps/etcher"
	cd ${S}/apps/etcher
	addconf="--disable-nls --with-included-gettext --disable-gtktest"
	cp configure.in{,.old}
	sed -e "s:intl/Makefile::" configure.in.old > configure.in
	eautogen ${baseconf} ${addconf} || die "could not autogen etcher"
	make CFLAGS="${CFLAGS} -levas" top_builddir=`pwd` || die "could not make etcher"
	make install DESTDIR="${D}" top_builddir=`pwd` || die "could not install etcher"

	### ebony ###
	einfo "making apps/ebony"
	cd ${S}/apps/ebony
	eautogen ${baseconf} || die "could not autogen ebony"
	make || die "could not make ebony"
	make install DESTDIR="${D}" || die "could not install ebony"

	### med ###
	einfo "making apps/med"
	cd ${S}/apps/med
	addconf=
	use X           && addconf="${addconf} --with-x"
	eautogen ${baseconf} ${addconf} || die "could not autogen med"
	make || die "could not build med"
	make install DESTDIR="${D}" || die "could not install med"

	### efsd ###
	einfo "making apps/efsd"
	cd ${S}/apps/efsd
	eautogen ${baseconf} || die "could not autogen efsd"
	make || die "could not build efsd"
	make install DESTDIR="${D}" || die "could not install efsd"

	### ebindings ###
	einfo "making apps/ebindings"
	cd ${S}/apps/ebindings
	addconf="--disable-gtktest"
	eautogen ${baseconf} ${addconf} || die "could not autogen ebindings"
	make || die "could not build ebindings"
	make install DESTDIR="${D}" || die "could not install ebindings"

	### e ###
	einfo "making apps/e"
	cd ${S}/apps/e
	addconf="--disable-nls"
	# hack it a little ;D
	cp configure.ac configure.ac.old
	sed -e 's:AC_MSG_ERROR(Cannot detect:#:' \
	 -e 's:intl/Makefile::' \
	 -e 's:po/Makefile.in::' \
		configure.ac.old > configure.ac
	cp Makefile.am Makefile.am.old
	sed -e 's:po::' Makefile.am.old > Makefile.am
	eautogen ${baseconf} ${addconf} || die "could not autogen e"
	cp Makefile Makefile.old
	sed -e 's:m4   ::' Makefile.old > Makefile
	make || die "could not build e"
	make install DESTDIR="${D}" >& /dev/null
	make install DESTDIR="${D}" || die "could not install e"

	############
	### misc ###
	############

	### elogin ###
	einfo "making misc/elogin"
	cd ${S}/misc/elogin
	eautogen ${baseconf} || die "could not autogen elogin"
	# now lets hax it to make it Gentoo style
	cd ${S}/misc/elogin/src/daemon && cp spawner.h{,.old}
	sed -e "s:.*ELOGIN.*:#define ELOGIN \"${E_PREFIX}/bin/elogin\":" \
		spawner.h.old > spawner.h
	cd ${S}/misc/elogin/src/client && cp callbacks.c{,.old}
	sed -e 's:/etc/X11/Xsession %s:%s:' \
		callbacks.c.old > callbacks.c
	cd ${S}/misc/elogin/data/config && cp build_config.sh{,.old}
	sed -e "s:/usr/local/e17:${E_PREFIX}:" \
	 -e 's:failsafe:/etc/X11/Sessions/Xsession:' \
	 -e 's:/usr/bin/kde:/usr/kde/3/bin/startkde:' \
		build_config.sh.old > build_config.sh
	rm build_config.sh.old
	./build_config.sh
	cd ${S}/misc/elogin
	make || die "could not build elogin"
	make install DESTDIR="${D}" || die "could not install elogin"
	insinto /etc/pam.d
	doins config/elogin

	############
	### fine ###
	############

	# remove improper stuff
	cd ${D}
	rm -rf `find -name CVS`
	rm -rf '@aclocaldir@'

	# make an env.d entry
	insinto /etc/env.d
	echo "PATH=${E_PREFIX}/bin:${E_PREFIX}/sbin" > e.env.d
	echo "LDPATH=${E_PREFIX}/lib" >> e.env.d
	newins e.env.d 50enlightenment
	rm -f e.env.d
}

pkg_preinst() {
	[ -h ${E_PREFIX} ] && rm ${E_PREFIX}
}

pkg_postinst() {
	if [ -e ${E_PREFIX}.old ] ; then
		ewarn "Remember, your old e17 is at ${E_PREFIX}.old"
		ewarn "be sure to do something with it !"
		echo
	fi
	einfo "If you wish you can use elogin as your login"
	einfo "manager.  For now, remove xdm from your startup"
	einfo "and add '/usr/e17/sbin/elogind' to the"
	einfo "/etc/conf.d/local.start file."
}
