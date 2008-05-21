# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-2.12.ebuild,v 1.1 2008/05/21 17:43:44 dertobi123 Exp $

EAPI="1"

inherit eutils depend.apache toolchain-funcs

MY_P=${PN/-core}-${PV/_}
DESCRIPTION="Nagios Core - Check daemon, CGIs, docs"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz
	mirror://gentoo/nagios-2.0b.cfg-sample.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug perl +web vim-syntax"
DEPEND="virtual/mailx
	web? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/gd-1.8.3-r5
		perl? ( net-analyzer/traceroute )
	)
	perl? ( >=dev-lang/perl-5.6.1-r7 )"
RDEPEND="${DEPEND}
	vim-syntax? ( app-vim/nagios-syntax )"

want_apache2

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# Check if gd has been compiled with jpeg and png support
	if use web; then
		if ! built_with_use media-libs/gd jpeg png; then
			eerror "Your gd has been compiled without jpeg and/or png support."
			eerror "Please re-emerge gd:"
			eerror "# USE="jpeg png" emerge gd"
			die "pkg_setup failed"
		fi
	fi

	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/2.x-series-nsca.patch

	local strip="$(echo '$(MAKE) strip-post-install')"
	sed -i -e "s:${strip}::" {cgi,base}/Makefile.in || die "sed failed in Makefile.in"
}

src_compile() {
	local myconf

	if use perl
	then
		myconf="${myconf} --enable-embedded-perl --with-perlcache"
	fi

	if use debug; then
		myconf="${myconf} --enable-DEBUG0"
		myconf="${myconf} --enable-DEBUG1"
		myconf="${myconf} --enable-DEBUG2"
		myconf="${myconf} --enable-DEBUG3"
		myconf="${myconf} --enable-DEBUG4"
		myconf="${myconf} --enable-DEBUG5"
	fi

	if use apache2 ; then
		myconf="${myconf} --with-command-grp=apache"
	else
		myconf="${myconf} --with-command-grp=nagios"
	fi

	econf ${myconf} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--datadir=/usr/nagios/share \
		|| die "./configure failed"

	emake CC=$(tc-getCC) nagios || die "make failed"

	if use web ; then
		# Only compile the CGI's if "web" useflag is set.
		make CC=$(tc-getCC) DESTDIR="${D}" cgis || die
	fi

	emake -C contrib all || "contrib make filed"

}

src_install() {
	dodoc Changelog INSTALLING LEGAL README UPGRADING
	docinto contrib
	dodoc contrib/README

	if ! use web; then
		sed -i -e 's/cd $(SRC_CGI) && $(MAKE) $@/# line removed due missing web use flag/' \
			-e 's/cd $(SRC_HTM) && $(MAKE) $@/# line removed due missing web use flag/' \
			Makefile
	fi

	sed -i -e 's/^contactgroups$//g' Makefile

	make DESTDIR="${D}" install
	make DESTDIR="${D}" install-config
	make DESTDIR="${D}" install-commandmode

	docinto sample-configs
	dodoc "${D}"/etc/nagios/*
	rm "${D}"/etc/nagios/*

	newdoc "${WORKDIR}"/nagios-2.0b.cfg-sample nagios.cfg-sample

	#contribs are not configured by the configure script, we'll configure them overselves...
	find "${S}"/contrib/ -type f | xargs sed -e 's:/usr/local/nagios/var/rw:/var/nagios/rw:;
						s:/usr/local/nagios/libexec:/usr/nagios/libexec:;
						s:/usr/local/nagios/etc:/etc/nagios:;
						s:/usr/local/nagios/sbin:/usr/nagios/sbin:;' -i

	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/eventhandlers

	doinitd "${FILESDIR}"/nagios

	chmod 644 "${S}"/contrib/*.cgi
	into /usr/nagios
	for bin in `find contrib/ -type f -perm 0755 -maxdepth 1` ; do
		dobin "$bin"
	done

	# Apache Module
	if use web ; then
		if use apache2 ; then
			insinto "${APACHE_MODULES_CONFDIR}"
			doins "${FILESDIR}"/99_nagios.conf
		else
			ewarn "${CATEGORY}/${PF} only supports apache-2.x webserver"
			ewarn "out-of-the-box. Since you are not using apache, you"
			ewarn "have to configure your webserver accordingly yourself."
		fi

		if use perl; then
			into /usr/nagios ; dosbin contrib/traceroute.cgi
		fi
	fi

	for dir in etc/nagios var/nagios ; do
		chown -R nagios:nagios "${D}/${dir}" || die "Failed chown of ${D}/${dir}"
	done

	chown -R root:root "${D}"/usr/nagios
	find "${D}"/usr/nagios -type d -print0 | xargs -0 chmod 755
	find "${D}"/usr/nagios/*bin -type f -print0 | xargs -0 chmod 755
	find "${D}"/usr/nagios/share -type f -print0 | xargs -0 chmod 644

	keepdir /etc/nagios
	keepdir /var/nagios
	keepdir /var/nagios/archives
	keepdir /usr/nagios/share/ssi
	keepdir /var/nagios/rw

	if use apache2 ; then
		chown -R nagios:apache "${D}"/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	else
		chown -R nagios:nagios "${D}"/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	fi

	chmod ug+s "${D}"/var/nagios/rw || die "Failed Chmod of ${D}/var/nagios/rw"
	chmod 0750 "${D}"/etc/nagios || die "Failed chmod of ${D}/etc/nagios"

	cat << EOF > "${T}"/55-nagios-core-revdep
SEARCH_DIRS="/usr/nagios/bin /usr/nagios/libexec"
EOF

	insinto /etc/revdep-rebuild
	doins "${T}"/55-nagios-core-revdep
}

pkg_postinst() {
	elog
	elog "The example config files are located at /usr/share/doc/${PF}/sample-configs/."
	elog
	elog "Also, if you want nagios to start at boot time"
	elog "remember to execute:"
	elog "  rc-update add nagios default"
	elog

	if use web; then
		elog "This does not include cgis that are perl-dependent"
		elog "Currently traceroute.cgi is perl-dependent"
		elog "To have ministatus.cgi requires copying of ministatus.c"
		elog "to cgi directory for compiling."

		elog "Note that the user your webserver is running at needs"
		elog "read-access to /etc/nagios."
		elog

		if use apache2 ; then
			elog "There are several possible solutions to accomplish this,"
			elog "choose the one you are most comfortable with:"
			elog "	usermod -G nagios apache"
			elog "or"
			elog "	chown nagios:apache /etc/nagios"
			elog
			elog "Also edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
			elog
			elog "That will make nagios's web front end visable via"
			elog "http://localhost/nagios/"
			elog
		else
			elog "IMPORTANT: Do not forget to add the user your webserver"
			elog "is running as to the nagios group!"
		fi

	else
		elog "Please note that you have installed Nagios without web interface."
		elog "Please don't file any bugs about having no web interface when you do this."
		elog "Thank you!"
	fi

	elog
	elog "If your kernel has /proc protection, nagios"
	elog "will not be happy as it relies on accessing the proc"
	elog "filesystem. You can fix this by adding nagios into"
	elog "the group wheel, but this is not recomended."
	elog

	elog
	ewarn "Use /usr/nagios/bin/convertcfg for configuration file conversion"
}

pkg_prerm() {
	[[ "${ROOT}" == "/" ]] && /etc/init.d/nagios stop
}
