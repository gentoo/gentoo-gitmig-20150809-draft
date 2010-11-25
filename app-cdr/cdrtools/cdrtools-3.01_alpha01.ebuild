# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrtools/cdrtools-3.01_alpha01.ebuild,v 1.1 2010/11/25 18:52:59 billie Exp $

EAPI=2

inherit multilib eutils toolchain-funcs flag-o-matic

MY_P="${P/_alpha/a}"

DESCRIPTION="A set of tools for CD/DVD reading and recording, including cdrecord"
HOMEPAGE="http://cdrecord.berlios.de/private/cdrecord.html"
SRC_URI="ftp://ftp.berlios.de/pub/cdrecord/$([[ -z ${PV/*_alpha*} ]] && echo 'alpha/')/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 CDDL-Schily"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="acl unicode"

DEPEND="acl? ( virtual/acl )
	!app-cdr/dvdrtools
	!app-cdr/cdrkit"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_alpha[0-9][0-9]}

src_prepare() {
	# Remove profiled make files.
	rm -f $(find . -name '*_p.mk') || die "rm profiled"

	# Adjusting hardcoded paths.
	sed -i -e 's:opt/schily:usr:' \
		$(find ./ -type f -name \*.[0-9ch] -exec grep -l 'opt/schily' '{}' '+') \
		|| die "sed opt/schily"

	sed -i -e "s:\(^INSDIR=\t\tshare/doc/\):\1${PF}/:" \
		$(find ./ -type f -exec grep -l 'INSDIR.\+doc' '{}' '+') \
		|| die "sed doc"

	# Respect libdir.
	sed -i -e "s:\(^INSDIR=\t\t\)lib:\1$(get_libdir):" \
		$(find ./ -type f -exec grep -l '^INSDIR.\+lib\(/siconv\)\?$' '{}' '+') \
		|| die "sed multilib"

	# Do not install static libraries.
	sed -i -e 's:include\t\t.*rules.lib::' \
		$(find ./ -type f -exec grep -l '^include.\+rules\.lib' '{}' '+') \
		|| die "sed rules"

	# Respect CC/CXX variables.
	cd "${S}"/RULES
	local tcCC=$(tc-getCC)
	local tcCXX=$(tc-getCXX)
	sed -i -e "/cc-config.sh/s|\$(C_ARCH:%64=%) \$(CCOM_DEF)|${tcCC} ${tcCC}|" \
		rules1.top || die "sed rules1.top"
	sed -i -e "/^\(CC\|DYNLD\|LDCC\|MKDEP\)/s|gcc|${tcCC}|" \
		-e "/^\(CC++\|DYNLDC++\|LDCC++\|MKC++DEP\)/s|g++|${tcCXX}|" \
		cc-gcc.rul || die "sed cc-gcc.rul"
	sed -i -e "s|^#CONFFLAGS +=\t-cc=\$(XCC_COM)$|CONFFLAGS +=\t-cc=${tcCC}|g" \
		rules.cnf || die "sed rules.cnf"

	# Create additional symlinks needed for some archs (armv4l already created)
	local t
	for t in armv4tl armv5l armv5tel armv6l armv7l ppc64 s390x; do
		ln -s i586-linux-cc.rul ${t}-linux-cc.rul || die
		ln -s i586-linux-gcc.rul ${t}-linux-gcc.rul || die
	done

	# Schily make setup.
	cd "${S}"/DEFAULTS
	local os="linux"

	sed -i \
		-e "s:/opt/schily:/usr:g" \
		-e "s:/usr/src/linux/include::g" \
		-e "s:bin:root:g" \
		Defaults.${os} || die "sed Schily make setup"
}

# skip obsolete configure script
src_configure() { : ; }

src_compile() {
	if use unicode; then
		local flags="$(test-flags -finput-charset=ISO-8859-1 -fexec-charset=UTF-8)"
		if [[ -n ${flags} ]]; then
			append-flags ${flags}
		else
			ewarn "Your compiler does not support the options required to build"
			ewarn "cdrtools with unicode in USE. unicode flag will be ignored."
		fi
	fi

	if ! use acl; then
		CFLAGS="${CFLAGS} -DNO_ACL"
	fi

	# LIB_ACL_TEST removed to support x86-fbsd
	# If not built with -j1, "sometimes" cdda2wav will not be built.
	emake -j1 CC="$(tc-getCC)" CPPOPTX="${CPPFLAGS}" COPTX="${CFLAGS}" \
		LDOPTX="${LDFLAGS}" \
		INS_BASE="${D}/usr" INS_RBASE="${D}" LINKMODE="dynamic" \
		RUNPATH="" GMAKE_NOWARN="true" || die "emake"
}

src_install() {
	# If not built with -j1, "sometimes" manpages are not installed.
	emake -j1 CC="$(tc-getCC)" CPPOPTX="${CPPFLAGS}" COPTX="${CFLAGS}" \
		LDOPTX="${LDFLAGS}" \
		INS_BASE="${D}/usr" INS_RBASE="${D}" LINKMODE="dynamic" \
		RUNPATH="" GMAKE_NOWARN="true" install || die "emake install"

	# These symlinks are for compat with cdrkit.
	dosym schily /usr/include/scsilib || die "dosym scsilib"
	dosym ../scg /usr/include/schily/scg || die "dosym scg"

	dodoc ABOUT Changelog* CONTRIBUTING PORTING README.linux-shm READMEs/README.linux \
		|| die "dodoc"

	cd "${S}"/cdda2wav
	docinto cdda2wav
	dodoc Changelog FAQ Frontends HOWTOUSE NEEDED README THANKS TODO \
		|| die "dodoc cdda2wav"

	cd "${S}"/mkisofs
	docinto mkisofs
	dodoc ChangeLog* TODO || die "dodoc mkisofs"

	# Remove man pages related to the build system
	rm -rvf "${D}"/usr/share/man/man5
}
