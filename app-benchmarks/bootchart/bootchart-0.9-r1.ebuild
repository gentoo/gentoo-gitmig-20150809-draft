# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bootchart/bootchart-0.9-r1.ebuild,v 1.3 2007/03/28 06:10:41 vapier Exp $

inherit multilib eutils java-pkg-opt-2 java-ant-2

DESCRIPTION="Performance analysis and visualization of the system boot process"
HOMEPAGE="http://www.bootchart.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acct debug doc java source"

DEPEND="
	java? (
		>=virtual/jdk-1.4
		>=dev-java/ant-core-1.4
		dev-java/commons-cli
		source? ( app-arch/zip )
	)
"
RDEPEND="
	java? (
		>=virtual/jdk-1.4
		dev-java/commons-cli
	)
	acct? ( sys-process/acct )
"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.9-gentoo.patch

	# delete the included commons-cli and use gentoo's instead
	# The rest of lib is also bundled but a bit problematic to
	# package https://bugs.gentoo.org/show_bug.cgi?id=162788
	rm -rf lib/org/apache/commons/cli lib/org/apache/commons/lang

	if use java ; then
		java-ant_rewrite-classpath
		sed -i -e 's,AUTO_RENDER="no",AUTO_RENDER="yes",g' \
			script/bootchartd.conf
	fi

	if use acct ; then
		sed -i -e 's,PROCESS_ACCOUNTING="no",PROCESS_ACCOUNTING="yes",g' \
			script/bootchartd.conf
	fi
}

src_compile() {
	if use java ; then
		local antflags="jar -Dcompiler.nowarn=true $(use_doc)"
		use debug || antflags="${antflags} -Dbuild.debug=false"
		eant ${antflags} \
			-Dgentoo.classpath="$(java-pkg_getjars commons-cli-1):./build"
	fi
}

src_install() {
	dodoc README README.logger ChangeLog COPYING TODO

	insinto /$(get_libdir)/rcscripts/addons
	doins "${FILESDIR}"/profiling-functions.sh

	into /
	newsbin script/bootchartd bootchartd
	into /usr

	# This dir is normally empty, but is used to bind to the
	# temporary dir bootchart normally makes. We do this so
	# that our profiling script can write to a fixed location.
	keepdir /lib/bootchart

	insinto /etc
	doins script/bootchartd.conf

	if use java ; then
		java-pkg_dojar "${PN}.jar"
		use doc && java-pkg_dojavadoc javadoc/api
		use source && java-pkg_dosrc src/org
		java-pkg_dolauncher ${PN} \
			--main org.bootchart.Main \
			--java_args "-Djava.awt.headless=true"
	fi
}

pkg_postinst() {
	elog "To generate the chart, set RC_USE_BOOTCHART=\"yes\""
	elog "in /etc/conf.d/rc and reboot"
	elog

	if use java; then
		elog "The chart will be saved as /var/log/bootchart.png"
	else
		elog "Post the file /var/log/bootchart.tgz here:"
		elog "   http://www.bootchart.org/download.html"
		elog "to render the chart"
	fi

	elog
	elog "For best results: "
	elog "  Enable BSD process accounting v3 in the kernel"
	elog "    This will produce more accurate process trees"
	elog "  Set AUTO_RENDER_FORMAT to svg in /etc/bootchartd.conf"
	elog "    and view /var/log/bootchart.svgz with batik or"
	elog "    Adobe SVG viewer. This will give you additional"
	elog "    information about the processes in tooltips"
}
