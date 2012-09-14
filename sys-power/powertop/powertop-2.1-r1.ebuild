# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-2.1-r1.ebuild,v 1.3 2012/09/14 13:33:55 zerochaos Exp $

EAPI="4"

inherit eutils linux-info
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/fenrus75/powertop.git"
	inherit git-2
	SRC_URI=""
else
	SRC_URI="https://01.org/powertop/sites/default/files/downloads/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="https://01.org/powertop/ http://www.lesswatts.org/projects/powertop/"

LICENSE="GPL-2"
SLOT="0"
IUSE="unicode X"

COMMON_DEPEND="
	dev-libs/libnl:3
	sys-apps/pciutils
	sys-devel/gettext
	sys-libs/ncurses[unicode?]
"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	${COMMON_DEPEND}
	X? ( x11-apps/xset )
"

DOCS=( TODO README )

pkg_setup() {
	einfo "Warning: enabling all suggested kconfig params may have performance impacts"
	CONFIG_CHECK="
		X86_MSR
		DEBUG_FS
		~PERF_EVENTS
		~TRACEPOINTS
		~NO_HZ
		~HIGH_RES_TIMERS
		~HPET_TIMER
		~CPU_FREQ_STAT
		~CPU_FREQ_GOV_ONDEMAND
		~SND_HDA_POWER_SAVE
		~USB_SUSPEND
		~TIMER_STATS
		~EVENT_POWER_TRACING_DEPRECATED
		~TRACING
	"
	linux-info_pkg_setup
}

src_configure() {
	export ac_cv_search_delwin=$(usex unicode -lncursesw -lncurses)
	default
}

src_compile() {
	#the clean is needed because the 2.1 tarball had object files in src/tuning/
	emake clean
	emake
}

src_install() {
	default
	keepdir /var/cache/powertop
}
