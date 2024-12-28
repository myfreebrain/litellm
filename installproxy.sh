# Install build dependencies
apt-get update && apt-get install -y gcc python3-dev

pip install --upgrade pip && pip install build

python -m build

pip install dist/*.whl

pip wheel --no-cache-dir --wheel-dir=/wheels/ -r requirements.txt

pip install redisvl==0.0.7 --no-deps

# ensure pyjwt is used, not jwt
pip uninstall jwt -y
pip uninstall PyJWT -y
pip install PyJWT==2.9.0 --no-cache-dir

chmod +x docker/build_admin_ui.sh && ./docker/build_admin_ui.sh

pip install *.whl /wheels/* --no-index --find-links=/wheels/

prisma generate
python3 litellm/proxy/prisma_migration.py

