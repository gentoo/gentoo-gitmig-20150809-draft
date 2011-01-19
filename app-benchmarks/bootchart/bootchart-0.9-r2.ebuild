# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bootchart/bootchart-0.9-r2.ebuild,v 1.7 2011/01/19 01:06:34 fordfrog Exp $

inherit multilib eutils java-pkg-opt-2 java-ant-2

DESCRIPTION="Performance analysis and visualization of the system boot process"
HOMEPAGE="http://www.bootchart.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
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

	epatch "${FILESDIR}/${P}"-gentoo.patch
	epatch "${FILESDIR}/${P}"-sh.patch

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
	dodoc README README.logger ChangeLog TODO

	# No need for this with baselayout-2
	if has_version "<sys-apps/baselayout-2"; then
		insinto /$(get_libdir)/rcscripts/addons
		doins "${FILESDIR}"/profiling-functions.sh
	fi

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
	if has_version "<sys-apps/baselayout-2"; then
		elog "To generate the chart, set RC_USE_BOOTCHART=\"yes\""
		elog "in /etc/conf.d/rc and reboot"
	else
		elog "To generate the chart, append this to your kernel commandline"
		elog "   init=/sbin/bootchartd"
		elog "and reboot."
		elog "Note: genkernel users should replace init= with real_init= in the above"
		elog "see https://bugs.gentoo.org/show_bug.cgi?id=275251 for more info"
	fi
	elog

	if use java; then
		elog "The chart will be saved as /var/log/bootchart.png"
	else
		elog "If you want to auto render chart of boot process, you"
		elog "have to enable 'java' USE flag on bootchart. For details"
		elog "see bootchart configuration file."
	fi

	elog
	elog "For best results: "

	if ! use acct ; then
		elog "  Enable 'acct' USE flag on bootchart to enable "
		elog "    process accounting support in bootchart"
	fi

	elog "  Enable BSD process accounting v3 in the kernel"
	elog "    This will produce more accurate process trees"
	elog "  Set AUTO_RENDER_FORMAT to svg in /etc/bootchartd.conf"
	elog "    and view /var/log/bootchart.svgz with batik or"
	elog "    Adobe SVG viewer. This will give you additional"
	elog "    information about the processes in tooltips"
}
