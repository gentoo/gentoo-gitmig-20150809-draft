# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/basc/basc-1.5.8.ebuild,v 1.3 2005/03/18 20:55:19 swegener Exp $

# ebuild contributed by Alexander Mieland and Daniel Herzog

inherit eutils toolchain-funcs

DESCRIPTION="Buildtime And Statistics Client for http://www.gentoo-stats.org"
HOMEPAGE="http://www.gentoo-stats.org"
SRC_URI="http://www.gentoo-stats.org/download/${P}.tar.gz mirror://gnu/bash/bash-3.0.tar.gz"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

IUSE="screenshot"

RDEPEND="app-portage/gentoolkit
	dev-lang/perl
	sys-devel/gcc
	sys-apps/sed
	sys-apps/grep
	app-arch/gzip
	sys-apps/diffutils
	sys-process/time
	sys-devel/bc
	>=sys-libs/ncurses-5.2-r2
	>=sys-apps/uhinv-0.4
	screenshot? (media-gfx/scrot)"

pkg_setup() {
	enewgroup stats
	enewuser stats -1 /bin/false /tmp stats
}

src_compile() {
	sed -i "s:/usr/local:/usr:g" client/basc client/basc-fs
	useq x86 && $(tc-getCC) ${CFLAGS} -o client/smt-detect client/smt-detect.c >/dev/null 2>&1
}

src_install() {
	exeinto /usr/bin
	doexe client/basc client/basc-fs client/urandom.sh
	useq x86 && doexe client/smt-detect
	dodoc README ChangeLog TEAM
	dodir /etc/basc
}

pkg_postinst() {

	chown -R root:stats ${ROOT}/etc/basc
	chmod -R ug+rw ${ROOT}/etc/basc

	einfo
	if [ -f ${ROOT}/etc/basc/basc.gu ]
	then
		einfo "Benchmark data present. To re-run the benchmark execute:"
		einfo "\"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo
		einfo "Now you can run basc by typing \"basc\"."
		einfo "To get help, type \"basc -h\"."
		einfo
		einfo "Note:"
		einfo
		einfo "You have to be in the stats group to use the client!"
		einfo "A user can be added to the stats group by executing:"
		einfo
		einfo "  \"usermod -G \$(groups <ME> | sed -e 's/ /,/g'),stats <ME>\""
		einfo
		einfo "Replace <ME> with your username on the system."
		einfo "After a login, you are ready to use the client."
		einfo
		einfo "If you want to automatically launch the client every 24h,"
		einfo "you must set up a cronjob for the stats user or a user in"
		einfo "the stats group."
		einfo
		einfo "For example:"
		einfo
		einfo "   \"0 0 * * * /usr/bin/basc -q -y >/dev/null 2>&1\""
		einfo
		einfo "will start the client every day at 00:00am"
		einfo
		ebeep
	else
		ewarn "Benchmark data not present. You will need to execute:"
		ewarn "\"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		ewarn "before using basc."
		einfo
		ebeep
		epause 2
	fi
}

pkg_config() {
	if [ ! -d ${T}/${PF} ]; then
		mkdir -p ${T}/${PF}
	else
		rm -f ${T}/${PF}/*
	fi
	cd ${T}/${PF}
	einfo
	einfo "I will benchmark your system now."
	einfo
	einfo "I'll unpack and compile bash-3.0 now. This package is "
	einfo "needed to use it as a benchmark for your system. It will not"
	einfo "be installed on your system. We only need to compile it,"
	einfo "to have the compiletime then as your GU for your system."
	einfo

	if [ ! -e ${DISTDIR}/bash-3.0.tar.gz ]; then
		eerror "I could not find the file ${DISTDIR}/bash-3.0.tar.gz. Please do:"
		eerror "# ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild fetch"
		die "Please fetch bash sources."
	fi
	unpack ${DISTFILES}/bash-3.0.tar.gz

	cd bash-3.0

	einfo "Configuring bash-3.0... please wait..."
	/usr/bin/time -p -o ../configure.time -a ./configure >/dev/null 2>&1

	einfo "Compiling bash-3.0... please wait..."
	/usr/bin/time -p -o ../make.time -a make >/dev/null 2>&1

	einfo "Calculating your GU for your system..."
	cd ..
	CONFTIME=`cat ./configure.time 2>/dev/null | head -n 1 | sed -e 's/^real \([^ ]*\)$/\1/'`
	MAKETIME=`cat ./make.time 2>/dev/null | head -n 1 | sed -e 's/^real \([^ ]*\)$/\1/'`
	GU=`echo "${CONFTIME} + ${MAKETIME}" | bc | cut -d "." -f 1`
	echo ${GU} > ./basc.gu
	cp ./basc.gu ${ROOT}/etc/basc/basc.gu

	einfo "Deleting temporary benchmark-files..."
	rm -fr ${T}/${PF}

	einfo
	einfo "Benchmarking successfully finished."
	einfo
	ewarn "Your GU: ${GU}"
	einfo
	einfo "Now you can run basc by typing \"basc\"."
	einfo "To get help, type \"basc -h\"."
	einfo
	einfo "Note:"
	einfo ""
	einfo "You have to be in the stats group to use the client!"
	einfo "A user can be added to the stats group by executing:"
	einfo ""
	einfo "  \"usermod -G \$(groups <ME> | sed -e 's/ /,/g'),stats <ME>\""
	einfo ""
	einfo "Replace <ME> with your username on the system."
	einfo "After a login, you are ready to use the client."
	einfo ""
	einfo "If you want to automatically launch the client every 24h,"
	einfo "you must set up a cronjob for the stats user or a user in"
	einfo "the stats group."
	einfo ""
	einfo "For example:"
	einfo ""
	einfo "   \"0 0 * * * /usr/bin/basc -q -y >/dev/null 2>&1\""
	einfo ""
	einfo "will start the client every day at 00:00am"
	einfo
	chown -R root:stats ${ROOT}/etc/basc
	chmod -R ug+rw ${ROOT}/etc/basc
}
