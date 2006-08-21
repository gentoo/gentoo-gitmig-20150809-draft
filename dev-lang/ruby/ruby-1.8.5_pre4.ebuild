# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.5_pre4.ebuild,v 1.1 2006/08/21 18:01:49 caleb Exp $

ONIGURUMA="onigd2_5_4"

inherit flag-o-matic alternatives eutils multilib autotools

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz
	cjk? ( http://www.geocities.jp/kosako3/oniguruma/archive/${ONIGURUMA}.tar.gz )"

LICENSE="Ruby"
SLOT="1.8"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="socks5 tcltk cjk doc threads examples ipv6"
RESTRICT="confcache"

RDEPEND="virtual/libc
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-proxy/dante-1.1.13 )
	tcltk? ( dev-lang/tk )
	>=dev-ruby/ruby-config-0.3
	!=dev-lang/ruby-cvs-1.8*
	!dev-ruby/rdoc
	!dev-ruby/rexml"

PROVIDE="virtual/ruby"

S="${WORKDIR}/ruby-${PV/_pre*/}"

src_unpack() {
	unpack ${A}

	if use cjk ; then
		einfo "Applying ${ONIGURUMA}"
		pushd "${WORKDIR}/oniguruma"
#		epatch ${FILESDIR}/oniguruma-2.3.1-gentoo.patch
		econf --with-rubydir="${S}" || die "econf failed"
		emake ${SLOT/./}
		popd
	fi

	cd "${S}"

	# Fix a hardcoded lib path in configure script
	sed -i -e "s:\(RUBY_LIB_PREFIX=\"\${prefix}/\)lib:\1$(get_libdir):" \
		configure.in || die "sed failed"

	eautoreconf
}

src_compile() {
	filter-flags -fomit-frame-pointer
	export EXTLDFLAGS="${LDFLAGS}"

	filter-flags -Wl,-Bdirect
	filter-ldflags -Wl,-Bdirect
	filter-ldflags -Bdirect

	append-flags -fno-strict-aliasing

	# Socks support via dante
	if use socks5; then
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		unset SOCKS_SERVER
	fi

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		append-flags "-DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
	fi

	# On ia64 we need to build without optimization #48824
	if use ia64; then
		replace-flags '-O*' -O0
	fi

	econf --program-suffix=${SLOT/./} --enable-shared \
		$(use_enable socks5 socks) \
		$(use_enable doc install-doc) \
		$(use_enable threads pthread) \
		$(use_enable ipv6 ipv6) \
		--with-sitedir=/usr/$(get_libdir)/ruby/site_ruby \
		|| die "econf failed"

	emake EXTLDFLAGS="${EXTLDFLAGS}" DLDFLAGS="${LDFLAGS}" || die "emake failed"

	# Remove the expanded ${LDFLAGS} variable on the configuration file
	sed -i -e 's:CONFIG\["LDFLAGS"\] =.*:CONFIG["LDFLAGS"] = "-Wl,-export-dynamic":' \
		rbconfig.rb
}

src_install() {
	LD_LIBRARY_PATH="${D}/usr/$(get_libdir)"
	RUBYLIB="${S}:${D}/usr/$(get_libdir)/ruby/${SLOT}"
	for d in $(find "${S}/ext" -type d) ; do
		RUBYLIB="${RUBYLIB}:$d"
	done
	export LD_LIBRARY_PATH RUBYLIB

	make DESTDIR="${D}" install || die "make install failed"

	if use doc; then
		make DESTDIR="${D}" install-doc || die "make install-doc failed"
	fi

	if use examples; then
		dodir "${ROOT}usr/share/doc/${PF}"
		cp -pPR sample "${D}/${ROOT}usr/share/doc/${PF}"
	fi

	if use ppc-macos ; then
		dosym /usr/lib/libruby${SLOT/./}.${PV%_*}.dylib /usr/lib/libruby.${PV%.*}.dylib
		dosym /usr/lib/libruby${SLOT/./}.${PV%_*}.dylib /usr/lib/libruby.${PV%_*}.dylib
	else
		dosym libruby${SLOT/./}.so.${PV%_*} /usr/$(get_libdir)/libruby.so.${PV%.*}
		dosym libruby${SLOT/./}.so.${PV%_*} /usr/$(get_libdir)/libruby.so.${PV%_*}
	fi

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

pkg_postinst() {
	if ! use ppc-macos ; then
		ewarn
		ewarn "Warning: Vim won't work if you've just updated ruby from"
		ewarn "1.6.x to 1.8.x due to the library version change."
		ewarn "In that case, you will need to remerge vim."
		ewarn

		if [ ! -n "$(readlink "${ROOT}usr/bin/ruby")" ] ; then
			"${ROOT}usr/sbin/ruby-config" ruby${SLOT/./}
		fi
		einfo
		einfo "You can change the default ruby interpreter by ${ROOT}usr/sbin/ruby-config"
		einfo
	fi
}

src_test() {

       if hasq test $FEATURES; then

               if ! hasq userpriv $FEATURES; then
                       einfo "Ruby's unit tests require the userpriv feature of portage.  Skipping."
               else
                      if emake -j1 check -n &> /dev/null; then
                       vecho ">>> Test phase [check]: ${CATEGORY}/${PF}"
                               if ! emake -j1 check; then
                               hasq test $FEATURES && die "Make check failed. See above for details."
                               hasq test $FEATURES || eerror "Make check failed. See above for details."
                               fi
                       fi
               fi

       fi
}



pkg_postrm() {
	if ! use ppc-macos ; then
		if [ ! -n "$(readlink "${ROOT}usr/bin/ruby")" ] ; then
			"${ROOT}usr/sbin/ruby-config" ruby${SLOT/./}
		fi
	fi
}
