EAPI="2"

PHP_EXT_NAME="stomp"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS EXPERIMENTAL README"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension to communicate with any Stomp compliant Message Brokers"
LICENSE="PHP-3"
SLOT="0"
IUSE="+ssl"

DEPEND="${DEPEND}
	ssl? ( dev-lang/php[ssl] )
"

RDEPEND="${DEPEND}"

src_compile() {
	my_conf="--enable-stomp
		$(use_with ssl openssl-dir=/usr)"
	php-ext-pecl-r2_src_compile
}
