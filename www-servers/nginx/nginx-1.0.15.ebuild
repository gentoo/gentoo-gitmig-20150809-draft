# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/nginx/nginx-1.0.15.ebuild,v 1.3 2012/04/15 17:01:38 maekke Exp $

EAPI="4"

# Maintainer notes:
# - http_rewrite-independent pcre-support makes sense for matching locations without an actual rewrite
# - any http-module activates the main http-functionality and overrides USE=-http
# - keep the following requirements in mind before adding external modules:
#   * alive upstream
#   * sane packaging
#   * builds cleanly
#   * does not need a patch for nginx core
# - TODO: test the google-perftools module (included in vanilla tarball)

# prevent perl-module from adding automagic perl DEPENDs
GENTOO_DEPEND_ON_PERL="no"

# http_uploadprogress (https://github.com/masterzen/nginx-upload-progress-module, BSD-2 license)
HTTP_UPLOAD_PROGRESS_MODULE_PV="0.8.3"
HTTP_UPLOAD_PROGRESS_MODULE_P="ngx_upload_progress-${HTTP_UPLOAD_PROGRESS_MODULE_PV}"
HTTP_UPLOAD_PROGRESS_MODULE_SHA1="c7c663f"
HTTP_UPLOAD_PROGRESS_MODULE_URI="http://github.com/masterzen/nginx-upload-progress-module/tarball/v${HTTP_UPLOAD_PROGRESS_MODULE_PV}"

# http_headers_more (http://github.com/agentzh/headers-more-nginx-module, BSD license)
HTTP_HEADERS_MORE_MODULE_PV="0.15"
HTTP_HEADERS_MORE_MODULE_P="ngx_http_headers_more-${HTTP_HEADERS_MORE_MODULE_PV}"
HTTP_HEADERS_MORE_MODULE_SHA1="137855d"
HTTP_HEADERS_MORE_MODULE_URI="http://github.com/agentzh/headers-more-nginx-module/tarball/v${HTTP_HEADERS_MORE_MODULE_PV}"

# http_push (http://pushmodule.slact.net/, MIT license)
HTTP_PUSH_MODULE_PV="0.692"
HTTP_PUSH_MODULE_P="nginx_http_push_module-${HTTP_PUSH_MODULE_PV}"
HTTP_PUSH_MODULE_URI="http://pushmodule.slact.net/downloads/${HTTP_PUSH_MODULE_P}.tar.gz"

# http_cache_purge (http://labs.frickle.com/nginx_ngx_cache_purge/, BSD-2 license)
HTTP_CACHE_PURGE_MODULE_PV="1.4"
HTTP_CACHE_PURGE_MODULE_P="ngx_cache_purge-${HTTP_CACHE_PURGE_MODULE_PV}"
HTTP_CACHE_PURGE_MODULE_URI="http://labs.frickle.com/files/${HTTP_CACHE_PURGE_MODULE_P}.tar.gz"

# HTTP Upload module from Valery Kholodkov
# (http://www.grid.net.ru/nginx/upload.en.html, BSD license)
HTTP_UPLOAD_MODULE_PV="2.2.0"
HTTP_UPLOAD_MODULE_P="nginx_upload_module-${HTTP_UPLOAD_MODULE_PV}"
HTTP_UPLOAD_MODULE_URI="http://www.grid.net.ru/nginx/download/${HTTP_UPLOAD_MODULE_P}.tar.gz"

# http_slowfs_cache (http://labs.frickle.com/nginx_ngx_slowfs_cache/, BSD-2 license)
HTTP_SLOWFS_CACHE_MODULE_PV="1.6"
HTTP_SLOWFS_CACHE_MODULE_P="ngx_slowfs_cache-${HTTP_SLOWFS_CACHE_MODULE_PV}"
HTTP_SLOWFS_CACHE_MODULE_URI="http://labs.frickle.com/files/${HTTP_SLOWFS_CACHE_MODULE_P}.tar.gz"

inherit eutils ssl-cert toolchain-funcs perl-module flag-o-matic

DESCRIPTION="Robust, small and high performance http and reverse proxy server"
HOMEPAGE="http://nginx.org"
SRC_URI="http://nginx.org/download/${P}.tar.gz
	nginx_modules_http_upload_progress? ( ${HTTP_UPLOAD_PROGRESS_MODULE_URI} -> ${HTTP_UPLOAD_PROGRESS_MODULE_P}.tar.gz )
	nginx_modules_http_headers_more? ( ${HTTP_HEADERS_MORE_MODULE_URI} -> ${HTTP_HEADERS_MORE_MODULE_P}.tar.gz )
	nginx_modules_http_push? ( ${HTTP_PUSH_MODULE_URI} )
	nginx_modules_http_cache_purge? ( ${HTTP_CACHE_PURGE_MODULE_URI} )
	nginx_modules_http_upload? ( ${HTTP_UPLOAD_MODULE_URI} )
	nginx_modules_http_slowfs_cache? ( ${HTTP_SLOWFS_CACHE_MODULE_URI} )"

LICENSE="as-is BSD BSD-2 GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"

NGINX_MODULES_STD="access auth_basic autoindex browser charset empty_gif fastcgi
geo gzip limit_req limit_zone map memcached proxy referer rewrite scgi ssi
split_clients upstream_ip_hash userid uwsgi"
NGINX_MODULES_OPT="addition dav degradation flv geoip gzip_static image_filter
mp4 perl random_index realip secure_link stub_status sub xslt"
NGINX_MODULES_MAIL="imap pop3 smtp"
NGINX_MODULES_3RD="
	http_upload_progress
	http_headers_more
	http_passenger
	http_push
	http_cache_purge
	http_upload
	http_slowfs_cache"

IUSE="aio debug +http +http-cache ipv6 libatomic +pcre ssl vim-syntax"

for mod in $NGINX_MODULES_STD; do
	IUSE="${IUSE} +nginx_modules_http_${mod}"
done

for mod in $NGINX_MODULES_OPT; do
	IUSE="${IUSE} nginx_modules_http_${mod}"
done

for mod in $NGINX_MODULES_MAIL; do
	IUSE="${IUSE} nginx_modules_mail_${mod}"
done

for mod in $NGINX_MODULES_3RD; do
	IUSE="${IUSE} nginx_modules_${mod}"
done

CDEPEND="
	pcre? ( >=dev-libs/libpcre-4.2 )
	ssl? ( dev-libs/openssl )
	http-cache? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_geo? ( dev-libs/geoip )
	nginx_modules_http_gzip? ( sys-libs/zlib )
	nginx_modules_http_gzip_static? ( sys-libs/zlib )
	nginx_modules_http_image_filter? ( media-libs/gd[jpeg,png] )
	nginx_modules_http_perl? ( >=dev-lang/perl-5.8 )
	nginx_modules_http_rewrite? ( >=dev-libs/libpcre-4.2 )
	nginx_modules_http_secure_link? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_xslt? ( dev-libs/libxml2 dev-libs/libxslt )"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	arm? ( dev-libs/libatomic_ops )
	libatomic? ( dev-libs/libatomic_ops )"
PDEPEND="vim-syntax? ( app-vim/nginx-syntax )"

pkg_setup() {
	if use nginx_modules_http_passenger; then
		einfo
		einfo "Passenger support has been removed from the nginx ebuild to"
		einfo "get rid of file collisions, its broken build system and"
		einfo "incompatibilities between passenger 2 and 3."
		einfo
		einfo "Please switch to passenger-3 standalone or use the"
		einfo "unicorn gem which provides a sane nginx-like architecture"
		einfo "out of the box."
		einfo
		einfo "For more information on sane ruby deployments with"
		einfo "passenger-3/unicorn go to:"
		einfo
		einfo "https://rvm.beginrescueend.com"
		einfo
		die "nginx_modules_http_passenger still in IUSE"
	fi

	ebegin "Creating nginx user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
	eend $?

	if use libatomic; then
		ewarn "GCC 4.1+ features built-in atomic operations."
		ewarn "Using libatomic_ops is only needed if using"
		ewarn "a different compiler or a GCC prior to 4.1"
	fi

	if [[ -n $NGINX_ADD_MODULES ]]; then
		ewarn "You are building custom modules via \$NGINX_ADD_MODULES!"
		ewarn "This nginx installation is not supported!"
		ewarn "Make sure you can reproduce the bug without those modules"
		ewarn "_before_ reporting bugs."
	fi

	if use !http; then
		ewarn "To actually disable all http-functionality you also have to disable"
		ewarn "all nginx http modules."
	fi
}

src_prepare() {
	sed -i 's/ make/ \\$(MAKE)/' "${S}"/auto/lib/perl/make
}

src_configure() {
	local myconf= http_enabled= mail_enabled=

	use aio       && myconf+=" --with-file-aio --with-aio_module"
	use debug     && myconf+=" --with-debug"
	use ipv6      && myconf+=" --with-ipv6"
	use libatomic && myconf+=" --with-libatomic"
	use pcre      && myconf+=" --with-pcre"

	# HTTP modules
	for mod in $NGINX_MODULES_STD; do
		if use nginx_modules_http_${mod}; then
			http_enabled=1
		else
			myconf+=" --without-http_${mod}_module"
		fi
	done

	for mod in $NGINX_MODULES_OPT; do
		if use nginx_modules_http_${mod}; then
			http_enabled=1
			myconf+=" --with-http_${mod}_module"
		fi
	done

	if use nginx_modules_http_fastcgi; then
		myconf+=" --with-http_realip_module"
	fi

	# third-party modules
	if use nginx_modules_http_upload_progress; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/masterzen-nginx-upload-progress-module-${HTTP_UPLOAD_PROGRESS_MODULE_SHA1}"
	fi

	if use nginx_modules_http_headers_more; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/agentzh-headers-more-nginx-module-${HTTP_HEADERS_MORE_MODULE_SHA1}"
	fi

	if use nginx_modules_http_push; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/${HTTP_PUSH_MODULE_P}"
	fi

	if use nginx_modules_http_cache_purge; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/${HTTP_CACHE_PURGE_MODULE_P}"
	fi

	if use nginx_modules_http_upload; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/${HTTP_UPLOAD_MODULE_P}"
	fi

	if use nginx_modules_http_slowfs_cache; then
		http_enabled=1
		myconf+=" --add-module=${WORKDIR}/${HTTP_SLOWFS_CACHE_MODULE_P}"
	fi

	if use http || use http-cache; then
		http_enabled=1
	fi

	if [ $http_enabled ]; then
		use http-cache || myconf+=" --without-http-cache"
		use ssl && myconf+=" --with-http_ssl_module"
	else
		myconf+=" --without-http --without-http-cache"
	fi

	# MAIL modules
	for mod in $NGINX_MODULES_MAIL; do
		if use nginx_modules_mail_${mod}; then
			mail_enabled=1
		else
			myconf+=" --without-mail_${mod}_module"
		fi
	done

	if [ $mail_enabled ]; then
		myconf+=" --with-mail"
		use ssl && myconf+=" --with-mail_ssl_module"
	fi

	# custom modules
	for mod in $NGINX_ADD_MODULES; do
		myconf+=" --add-module=${mod}"
	done

	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	tc-export CC

	if ! use prefix; then
		myconf+=" --user=${PN} --group=${PN}"
	fi

	./configure \
		--prefix="${EPREFIX}"/usr \
		--sbin-path="${EPREFIX}"/usr/sbin/nginx \
		--conf-path="${EPREFIX}"/etc/${PN}/${PN}.conf \
		--error-log-path="${EPREFIX}"/var/log/${PN}/error_log \
		--pid-path="${EPREFIX}"/var/run/${PN}.pid \
		--lock-path="${EPREFIX}"/var/lock/nginx.lock \
		--with-cc-opt="-I${EROOT}usr/include" \
		--with-ld-opt="-L${EROOT}usr/lib" \
		--http-log-path="${EPREFIX}"/var/log/${PN}/access_log \
		--http-client-body-temp-path="${EPREFIX}"/var/tmp/${PN}/client \
		--http-proxy-temp-path="${EPREFIX}"/var/tmp/${PN}/proxy \
		--http-fastcgi-temp-path="${EPREFIX}"/var/tmp/${PN}/fastcgi \
		--http-scgi-temp-path="${EPREFIX}"/var/tmp/${PN}/scgi \
		--http-uwsgi-temp-path="${EPREFIX}"/var/tmp/${PN}/uwsgi \
		${myconf} || die "configure failed"
}

src_compile() {
	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	keepdir /var/log/${PN} /var/tmp/${PN}/{client,proxy,fastcgi,scgi,uwsgi}
	keepdir /var/www/localhost/htdocs

	dosbin objs/nginx
	newinitd "${FILESDIR}"/nginx.initd nginx

	cp "${FILESDIR}"/nginx.conf conf/nginx.conf || die
	rm conf/win-utf conf/koi-win conf/koi-utf

	dodir /etc/${PN}
	insinto /etc/${PN}
	doins conf/*

	doman man/nginx.8
	dodoc CHANGES* README

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/nginx.logrotate nginx

	if use nginx_modules_http_perl; then
		cd "${S}"/objs/src/http/modules/perl/
		einstall DESTDIR="${D}" INSTALLDIRS=vendor
		fixlocalpod
	fi

	if use nginx_modules_http_push; then
		docinto ${HTTP_PUSH_MODULE_P}
		dodoc "${WORKDIR}"/${HTTP_PUSH_MODULE_P}/{changelog.txt,protocol.txt,README}
	fi

	if use nginx_modules_http_cache_purge; then
		docinto ${HTTP_CACHE_PURGE_MODULE_P}
		dodoc "${WORKDIR}"/${HTTP_CACHE_PURGE_MODULE_P}/{CHANGES,README.md,TODO.md}
	fi

	if use nginx_modules_http_upload; then
		docinto ${HTTP_UPLOAD_MODULE_P}
		dodoc "${WORKDIR}"/${HTTP_UPLOAD_MODULE_P}/{Changelog,README}
	fi

	if use nginx_modules_http_slowfs_cache; then
		docinto ${HTTP_SLOWFS_CACHE_MODULE_P}
		dodoc "${WORKDIR}"/${HTTP_SLOWFS_CACHE_MODULE_P}/{CHANGES,README}
	fi
}

pkg_postinst() {
	if use ssl; then
		if [ ! -f "${EROOT}"/etc/ssl/${PN}/${PN}.key ]; then
			install_cert /etc/ssl/${PN}/${PN}
			use prefix || chown ${PN}:${PN} "${EROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
		fi
	fi
}
