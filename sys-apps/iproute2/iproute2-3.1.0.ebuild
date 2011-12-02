# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-3.1.0.ebuild,v 1.1 2011/12/02 22:24:35 vapier Exp $

EAPI=4

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git"

if [[ ${PV} == *.*.*.* ]] ; then
	MY_PV=${PV%.*}-${PV##*.}
else
	MY_PV=${PV}
fi
MY_P="${PN}-${MY_PV}"

inherit eutils toolchain-funcs flag-o-matic
[[ ${PV} == "9999" ]] && inherit git-2

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2"
[[ ${PV} == "9999" ]] || SRC_URI="mirror://kernel/linux/utils/networking/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
[[ ${PV} == "9999" ]] || KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="atm berkdb minimal"

RDEPEND="!net-misc/arpd
	!minimal? ( berkdb? ( sys-libs/db ) )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	>=sys-kernel/linux-headers-2.6.27
	elibc_glibc? ( >=sys-libs/glibc-2.7 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.1.0-mtu.patch #291907

	sed -i \
		-e "/^LIBDIR/s:=.*:=/$(get_libdir):" \
		-e "s:-O2:${CFLAGS} ${CPPFLAGS}:" \
		Makefile || die

	# build against system headers
	rm -r include/netinet #include/linux include/ip{,6}tables{,_common}.h include/libiptc

	# don't build arpd if USE=-berkdb #81660
	use berkdb || sed -i '/^TARGETS=/s: arpd : :' misc/Makefile

	use minimal && sed -i -e '/^SUBDIRS=/s:=.*:=lib tc:' Makefile
}

src_configure() {
	tc-export AR CC PKG_CONFIG

	# This sure is ugly.  Should probably move into toolchain-funcs at some point.
	local setns
	pushd "${T}" >/dev/null
	echo 'main(){return setns();};' > test.c
	${CC} ${CFLAGS} ${LDFLAGS} test.c >&/dev/null && setns=y || setns=n
	popd >/dev/null

	cat <<-EOF > Config
	TC_CONFIG_ATM := $(usex atm y n)
	IP_CONFIG_SETNS := ${setns}
	# Use correct iptables dir, #144265 #293709
	IPT_LIB_DIR := $(${PKG_CONFIG} xtables --variable=xtlibdir)
	EOF
}

src_install() {
	if use minimal ; then
		into /
		dosbin tc/tc
		return 0
	fi

	emake \
		DESTDIR="${D}" \
		SBINDIR=/sbin \
		DOCDIR=/usr/share/doc/${PF} \
		MANDIR=/usr/share/man \
		install

	dolib.a lib/libnetlink.a
	insinto /usr/include
	doins include/libnetlink.h

	if use berkdb ; then
		dodir /var/lib/arpd
		# bug 47482, arpd doesn't need to be in /sbin
		dodir /usr/sbin
		mv "${ED}"/sbin/arpd "${ED}"/usr/sbin/
	fi
}
