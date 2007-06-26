# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sara/sara-6.0.7d.ebuild,v 1.5 2007/06/26 02:21:50 mr_bones_ Exp $

DESCRIPTION="SARA Security Auditor's Research Assistant is a derived work of Security Administrator Tool for Analyzing Networks SATAN"
SRC_URI="http://www-arc.com/sara/downloads/${P}.tgz"
RESTRICT="nomirror"
HOMEPAGE="http://www-arc.com/sara/"

SLOT="0"
LICENSE="satan"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND=">=dev-lang/perl-5.8
	>=app-shells/tcsh-6.14-r3
	net-misc/netkit-rsh
	app-arch/sharutils
	net-misc/netkit-fingerd
	net-analyzer/nmap
	net-ftp/ftp
	X? ( || ( ( x11-libs/libX11
				x11-proto/xproto )
			virtual/x11 ) )"

SARA_HOME=/opt/sara

src_compile(){
	econf || die
	# does not like to build in parallel
	emake -j1 || die
}

src_install(){
	dodir ${SARA_HOME}
	insinto ${SARA_HOME}
	doins add_user reconfig
	exeinto ${SARA_HOME}
	doexe sara
	dodir ${SARA_HOME}/administrators
	dodir ${SARA_HOME}/bin
	exeinto ${SARA_HOME}/bin ; doexe bin/*
	dodir ${SARA_HOME}/config
	insinto ${SARA_HOME}/config ; doins config/*
	dodir ${SARA_HOME}/perl
	insinto ${SARA_HOME}/perl ;  doins perl/*.pl
	dodir ${SARA_HOME}/perl/contrib
	insinto ${SARA_HOME}/perl/contrib ; doins perl/contrib/*
	dodir ${SARA_HOME}/perl/Modules/Net
	insinto ${SARA_HOME}/perl/Modules/Net ; doins perl/Modules/Net/*
	dodir ${SARA_HOME}/rules
	insinto ${SARA_HOME}/rules
	doins rules/drop rules/corrections.default rules/facts rules/hosttype rules/*.rules \
		rules/services rules/timing rules/todo rules/trust
	dodir ${SARA_HOME}/plugins ; dodir ${SARA_HOME}/plugins/images
	insinto ${SARA_HOME}/plugins ; doins plugins/cis* plugins/README
	insinto ${SARA_HOME}/plugins/images ; doins plugins/images/*
	dodir ${SARA_HOME}/sss
	insinto ${SARA_HOME}/sss ; doins sss/*
	dodir ${SARA_HOME}/perllib
	insinto ${SARA_HOME}/perllib; doins perllib/*
	dodir ${SARA_HOME}/encoded
	insinto ${SARA_HOME}/encoded; doins encoded/*
	#html stuff

	dodir ${SARA_HOME}/html
	dodir ${SARA_HOME}/html/{admin,cve,data,docs,dots,images,reporting,running,search,update}
	dodir ${SARA_HOME}/html/tutorials
	dodir ${SARA_HOME}/html/tutorials/{first_time,vulnerability}
	dodir ${SARA_HOME}/html/tutorials/vulnerability/{base,cert,no_cve}

	insinto ${SARA_HOME}/html ; doins html/*.pl html/*.html
	insinto ${SARA_HOME}/html/admin ; doins html/admin/*
	insinto ${SARA_HOME}/html/cve ; doins html/cve/*
	insinto ${SARA_HOME}/html/data ; doins html/data/*
	insinto ${SARA_HOME}/html/docs ; doins html/docs/*
	insinto ${SARA_HOME}/html/dots ; doins html/dots/*
	insinto ${SARA_HOME}/html/images ; doins html/images/*
	insinto ${SARA_HOME}/html/reporting ; doins html/reporting/*
	insinto ${SARA_HOME}/html/running ; doins html/running/*
	insinto ${SARA_HOME}/html/search ; doins html/search/*
	insinto ${SARA_HOME}/html/tutorials ; doins html/tutorials/*pl
	insinto ${SARA_HOME}/html/tutorials/first_time ; doins html/tutorials/first_time/*
	insinto ${SARA_HOME}/html/tutorials/vulnerability ; doins html/tutorials/vulnerability/*html
	insinto ${SARA_HOME}/html/tutorials/vulnerability/base
	doins html/tutorials/vulnerability/base/*
	insinto ${SARA_HOME}/html/tutorials/vulnerability/cert
	doins html/tutorials/vulnerability/cert/*
	insinto ${SARA_HOME}/html/tutorials/vulnerability/no_cve
	doins html/tutorials/vulnerability/no_cve/*

	dodir /usr/sbin
	exeinto /usr/sbin; doexe "${FILESDIR}"/sara
	doman docs/sara.8
}

pkg_postinst() {
	elog "Read the documentation in ${SARA_HOME}/html before running this program."
	elog "You must have installed a web browser."
}
